import { atom, read, update } from 'claude-code'
import type { EngineInterface, Register } from 'claude-code'

import type { Entry } from '../types'

const PANE = 'prompt-sidebar'
const entries = atom({ plugin: 'prompt-sidebar', key: 'entries' } as const, [])
const selected = atom({ plugin: 'prompt-sidebar', key: 'selected' } as const, null)
const focused = atom({ plugin: 'prompt-sidebar', key: 'focused' } as const, null)

function keyOf(text: string) {
  return 'msg:' + text.trim()
}

// Rebuild the list from the stored conversation (a resumed session starts empty).
async function seed($: EngineInterface) {
  try {
    const msgs = await $.session.messages()
    const found: Entry[] = []
    for (const m of msgs) {
      const t = m.text.trim()
      if (m.role !== 'user' || m.toolResults?.length || !t || t.startsWith('<')) continue
      found.push({ id: keyOf(t), label: t.replace(/\s+/g, ' ').slice(0, 200) })
    }
    await update($, entries, l => [...l, ...found.filter(f => !l.some(one => one.id === f.id))])
  } catch {
    // keep the sidebar usable if history can't be read
  }
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.command.register({
      name: 'prompt-sidebar',
      description: 'Open the sidebar of your messages',
    })
    void $.ui.open({ id: PANE, title: 'Messages', columns: 28 })
    await seed($)

    return next(e)
  })

  on('command.run', { command: 'prompt-sidebar' }, async $ => {
    await seed($)
    await $.ui.open({ id: PANE, title: 'Messages', columns: 28, focus: true })

    return { text: 'Sidebar focused: arrows move, Enter jumps, Esc returns.' }
  })

  const fit = (t: string, width: number) => (t.length > width ? t.slice(0, Math.max(1, width - 1)) + '…' : t)
  const rows = new Map<string, string>()
  const shown = new Map<string, number>()

  on('prompt.submit', async ($, e, next) => {
    const text = e.text
    if (text.trim()) {
      const id = keyOf(text)
      const label = text.replace(/\s+/g, ' ').trim().slice(0, 200)
      await update($, entries, l => (l.some(one => one.id === id) ? l : [...l, { id, label }]))
    }

    return next(e)
  })

  // Tag each user row with a key so the sidebar can scroll to it.
  on('ui.render', { component: 'UserMessage' }, async ($, e, next) => {
    const { Box } = $.ui.resolve(e)
    const text = (e.props as { text?: string }).text
    const tree = await next(e)
    if (!text) return tree
    const isOn = (e.props as { onScreen?: unknown }).onScreen ? 1 : 0
    const isNew = !rows.has(keyOf(text))
    const was = shown.get(e.requestId)
    rows.set(keyOf(text), e.requestId)
    shown.set(e.requestId, isOn)
    if (isNew || was !== isOn) $.ui.invalidate('ui.render')
    const props = e.props as { origin?: { kind: string }; from?: unknown; task?: unknown }
    const kind = props.origin?.kind
    if (!props.from && !props.task && (kind === undefined || kind === 'composer' || kind === 'bridge' || kind === 'unclassified')) {
      const id = keyOf(text)
      const label = text.replace(/\s+/g, ' ').trim().slice(0, 200)
      try {
        const list = await read($, entries)
        if (!list.some(one => one.id === id)) await update($, entries, l => (l.some(one => one.id === id) ? l : [...l, { id, label }]))
      } catch {
        // drawing must never fail on bookkeeping
      }
    }

    return <Box key={keyOf(text)}>{tree}</Box>
  })

  on('ui.focus', { requestId: PANE }, async ($, e, next) => {
    await update($, focused, () => e.element ?? null)

    return next(e)
  })

  on('ui.render', { component: 'Pane', requestId: PANE }, async ($, e) => {
    const { Box, Text, Button } = $.ui.resolve(e)
    const list = (await read($, entries)).filter((one: Entry) => rows.has(one.id))
    const focus = await read($, focused)
    const current = await read($, selected)
    const width = (e.props as { bodyColumns?: number }).bodyColumns ?? 28

    return (
      <Box flexDirection="column">
        {list.length === 0 && <Text dimColor>No messages yet.</Text>}
        {list.map((one: Entry) => {
          const text = one.label || '(empty)'
          const isPicked = current === one.id
          const isHere = focus === one.id
          return (
            <Button
              key={one.id}
              label={text}
              plain
              onPress={async () => {
                await update($, selected, () => one.id)
                const rid = rows.get(one.id)
                const r = await $.ui.scroll({ to: rid ? { requestId: rid } : { key: one.id }, block: 'start' })
                if (r.deny) void $.ui.toast(`scroll refused: ${r.deny}`)
              }}
            >
              {isHere ? (
                <Text>{fit(text, width - 3).padEnd(width - 3)}</Text>
              ) : (
                <Text dimColor={!isPicked} color={isPicked ? 'success' : undefined}>
                  {fit(text, width - 3)}
                </Text>
              )}
            </Button>
          )
        })}
        <Button
          key="next-prompt"
          label="Next Prompt"
          plain
          dimColor
          onPress={async () => {
            await $.ui.close({ id: PANE })
            await $.ui.open({ id: PANE, title: 'Messages', columns: 28 })
          }}
        >
          {'» Next Prompt'}
        </Button>
      </Box>
    )
  })
}

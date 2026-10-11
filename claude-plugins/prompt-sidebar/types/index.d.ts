export type Entry = { id: string; label: string };

declare module 'claude-code' {
  interface PluginState {
    'prompt-sidebar': { entries: Entry[]; selected: string | null; focused: string | null };
  }
}

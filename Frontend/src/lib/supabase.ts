import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL as string | undefined;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined;

export const isSupabaseConfigured = Boolean(supabaseUrl && supabaseAnonKey);
// A syntactically valid inert client lets the UI show a helpful setup error
// instead of crashing before configuration is supplied.
export const supabase = createClient(
  supabaseUrl || 'https://reunite-unconfigured.supabase.co',
  supabaseAnonKey || 'unconfigured-anon-key',
);

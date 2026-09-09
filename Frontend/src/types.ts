export type ReportKind = 'Missing' | 'Found';
export type ReportStatus = 'Open' | 'Closed';

export interface Governorate {
  id: string;
  name: string;
}

export interface City {
  id: string;
  gov_id: string;
  name: string;
}

export interface Report {
  id: string;
  kind: ReportKind;
  name: string;
  age: number | null;
  gender: string | null;
  occurrence_date: string | null;
  occurrence_location: string | null;
  latitude?: number | null;
  longitude?: number | null;
  description: string | null;
  status: ReportStatus;
  created_at: string;
  photos?: { id: string; path: string }[];
  reporter_name?: string | null;
  reporter_phone?: string | null;
}

export interface Comment {
  id: string;
  report_id: string;
  user_id: string;
  content: string;
  added_at: string;
  users?: { name: string } | null;
  author_name?: string | null;
  author_phone?: string | null;
}

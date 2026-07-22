-- PsiGestão D1 Schema
-- Auto-migrates on first deploy

CREATE TABLE IF NOT EXISTS auth (
  id INTEGER PRIMARY KEY DEFAULT 1,
  password TEXT NOT NULL DEFAULT 'ojoaojm123',
  token TEXT
);

CREATE TABLE IF NOT EXISTS patients (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT DEFAULT '',
  email TEXT DEFAULT '',
  notes TEXT DEFAULT '',
  session_value REAL,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS appointments (
  id TEXT PRIMARY KEY,
  patient_id TEXT NOT NULL,
  date TEXT NOT NULL,
  time TEXT NOT NULL,
  duration INTEGER DEFAULT 50,
  status TEXT DEFAULT 'pending',
  payment TEXT DEFAULT 'pending',
  payment_method TEXT DEFAULT 'pix-pos',
  notes TEXT DEFAULT '',
  value REAL,
  created_at TEXT DEFAULT (datetime('now')),
  is_note INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS settings (
  id INTEGER PRIMARY KEY DEFAULT 1,
  session_value REAL DEFAULT 150,
  duration INTEGER DEFAULT 50,
  name TEXT DEFAULT 'Dr(a)',
  whatsapp TEXT DEFAULT '',
  crp TEXT DEFAULT '',
  endereco TEXT DEFAULT '',
  telefone TEXT DEFAULT '',
  pix TEXT DEFAULT '',
  notify INTEGER DEFAULT 1,
  msg_confirm TEXT DEFAULT 'Olá {nome}! Sua consulta foi confirmada para {data} às {hora}. Estarei esperando por você. ★',
  msg_remind TEXT DEFAULT 'Olá {nome}! Lembrete: amanhã temos consulta às {hora}. Confirme sua presença! ★',
  msg_cancel TEXT DEFAULT 'Olá {nome}! Sua consulta de {data} às {hora} precisou ser cancelada. Me avise se quiser reagendar. ★',
  video_link TEXT DEFAULT 'https://meet.google.com/'
);

CREATE TABLE IF NOT EXISTS booking_links (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  days TEXT DEFAULT '["Seg","Ter","Qua","Qui","Sex"]',
  start_hour TEXT DEFAULT '08:00',
  end_hour TEXT DEFAULT '18:00',
  duration INTEGER DEFAULT 50,
  price REAL,
  gap INTEGER DEFAULT 10,
  message TEXT DEFAULT '',
  active INTEGER DEFAULT 1,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS notes_entries (
  id TEXT PRIMARY KEY,
  text TEXT DEFAULT '',
  created_at TEXT DEFAULT (datetime('now')),
  updated_at TEXT
);

CREATE TABLE IF NOT EXISTS mural_items (
  id TEXT PRIMARY KEY,
  icon TEXT DEFAULT '📌',
  title TEXT NOT NULL,
  desc_text TEXT DEFAULT '',
  url TEXT DEFAULT ''
);

-- Seed default settings if not exists
INSERT OR IGNORE INTO settings (id, session_value, duration, name, msg_confirm, msg_remind, msg_cancel, video_link)
VALUES (1, 150, 50, 'Dr(a)',
  'Olá {nome}! Sua consulta foi confirmada para {data} às {hora}. Estarei esperando por você. ★',
  'Olá {nome}! Lembrete: amanhã temos consulta às {hora}. Confirme sua presença! ★',
  'Olá {nome}! Sua consulta de {data} às {hora} precisou ser cancelada. Me avise se quiser reagendar. ★',
  'https://meet.google.com/');

-- Seed default mural items
INSERT OR IGNORE INTO mural_items (id, icon, title, desc_text, url) VALUES
  ('m1', '📋', 'Código de Ética CFP', 'Resolução CFP nº 010/2005', 'https://site.cfp.org.br/wp-content/uploads/2012/07/codigo-de-etica-psicologia.pdf'),
  ('m2', '📊', 'Tabela de Honorários SUGESTÃO', 'Referência de valores por região', '#'),
  ('m3', '📄', 'Modelo de Contrato Terapêutico', 'Documento padrão para novos pacientes', '#'),
  ('m4', '⚖️', 'Resoluções CFP', 'Legislação atualizada do exercício profissional', 'https://site.cfp.org.br/legislacao/'),
  ('m5', '📞', 'CVV - Centro de Valorização da Vida', 'Apoio emocional gratuito: 188', 'https://www.cvv.org.br/');

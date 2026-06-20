SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS afterhours_events (
  id              CHAR(16)      NOT NULL,
  host_id         VARCHAR(60)   NOT NULL,
  name            VARCHAR(80)   NOT NULL,
  description     TEXT,
  flyer_url       VARCHAR(500)  NOT NULL DEFAULT '',
  type            VARCHAR(16)   NOT NULL,
  starts_at       DATETIME      NOT NULL,
  ends_at         DATETIME      NULL DEFAULT NULL,
  loc_x           DOUBLE        NOT NULL,
  loc_y           DOUBLE        NOT NULL,
  loc_z           DOUBLE        NOT NULL,
  radius          FLOAT         NOT NULL DEFAULT 30,
  routing_bucket  INT           NOT NULL DEFAULT 0,
  cover_charge    INT           NOT NULL DEFAULT 0,
  invite_only     TINYINT(1)    NOT NULL DEFAULT 0,
  guest_cap       INT           NOT NULL DEFAULT 50,
  status          VARCHAR(16)   NOT NULL,
  cancelled_at    DATETIME      NULL,
  cancel_refund   TINYINT(1)    NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  INDEX idx_host (host_id),
  INDEX idx_afterhours_events_starts_at_status (starts_at DESC, status),
  INDEX idx_afterhours_events_host_id_starts_at (host_id, starts_at DESC)
);

CREATE TABLE IF NOT EXISTS afterhours_cohosts (
  event_id    CHAR(16)    NOT NULL,
  cohost_id   VARCHAR(60) NOT NULL,
  PRIMARY KEY (event_id, cohost_id),
  CONSTRAINT fk_cohosts_event FOREIGN KEY (event_id) REFERENCES afterhours_events(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS afterhours_invitations (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  event_id       CHAR(16)    NOT NULL,
  invitee_id     VARCHAR(60) NOT NULL,
  invitee_name   VARCHAR(80) NULL,
  invited_by     VARCHAR(60) NOT NULL,
  rsvp           VARCHAR(8)  NOT NULL DEFAULT 'pending',
  responded_at   DATETIME    NULL,
  notified_at    DATETIME    NULL,
  created_at     DATETIME    DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uniq_event_invitee (event_id, invitee_id),
  INDEX idx_invitee (invitee_id),
  CONSTRAINT fk_inv_event FOREIGN KEY (event_id) REFERENCES afterhours_events(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS afterhours_checkins (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  event_id      CHAR(16)    NOT NULL,
  identifier    VARCHAR(60) NOT NULL,
  amount_paid   INT         NOT NULL DEFAULT 0,
  checked_in_at DATETIME    DEFAULT CURRENT_TIMESTAMP,
  present       TINYINT(1)  NOT NULL DEFAULT 1,
  last_seen_at  DATETIME    DEFAULT CURRENT_TIMESTAMP,
  left_at       DATETIME    NULL,
  UNIQUE KEY uniq_event_identifier (event_id, identifier),
  INDEX idx_event (event_id),
  CONSTRAINT fk_chk_event FOREIGN KEY (event_id) REFERENCES afterhours_events(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS afterhours_pending_payouts (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  payee_id   VARCHAR(60) NOT NULL,
  event_id   CHAR(16)    NOT NULL,
  amount     INT         NOT NULL,
  paid_at    DATETIME    NULL,
  INDEX idx_payee_unpaid (payee_id, paid_at),
  CONSTRAINT fk_pay_event FOREIGN KEY (event_id) REFERENCES afterhours_events(id) ON DELETE CASCADE
);

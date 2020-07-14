// mysql create table for sql_user:
CREATE TABLE sql_user
(
  uid            INT         PRIMARY KEY AUTO_INCREMENT,
  username       VARCHAR(16) NOT NULL UNIQUE,
  display_name   TEXT        NULL,
  email          TEXT        NULL,
  quota          TEXT        NULL,
  home           TEXT        NULL,
  password       TEXT        NOT NULL,
  active         TINYINT(1)  NOT NULL DEFAULT '1',
  disabled       TINYINT(1)  NOT NULL DEFAULT '0',
  provide_avatar BOOLEAN     NOT NULL DEFAULT FALSE,
  salt           TEXT        NULL
);

CREATE TABLE sql_group
(
  gid   INT         PRIMARY KEY AUTO_INCREMENT,
  name  VARCHAR(16) NOT NULL UNIQUE,
  admin BOOLEAN     NOT NULL DEFAULT FALSE
);

CREATE TABLE sql_user_group
(
  uid INT NOT NULL,
  gid INT NOT NULL,
  PRIMARY KEY (uid, gid),
  FOREIGN KEY (uid) REFERENCES sql_user (uid),
  FOREIGN KEY (gid) REFERENCES sql_group (gid),
  INDEX user_group_username_idx (uid),
  INDEX user_group_group_name_idx (gid)
);
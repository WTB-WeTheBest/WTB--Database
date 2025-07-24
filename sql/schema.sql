CREATE TABLE marker (
    id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    contact VARCHAR(100) NOT NULL,
    url VARCHAR(255) NOT NULL,
    min_price INT NOT NULL DEFAULT 0 CHECK (min_price >= 0),
    max_price INT NOT NULL DEFAULT 0 CHECK (max_price >= 0)
);

CREATE TABLE activity (
    id UUID NOT NULL PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES marker(id)
);

CREATE TABLE landmark (
    id UUID NOT NULL PRIMARY KEY,
    story TEXT,
    FOREIGN KEY (id) REFERENCES marker(id)
);

CREATE TABLE picture (
    id UUID NOT NULL PRIMARY KEY,
    id_marker UUID NOT NULL,
    url VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_marker) REFERENCES marker(id)
);

CREATE TABLE location (
    id UUID NOT NULL PRIMARY KEY,
    coordinates GEOGRAPHY(Point, 4326) NOT NULL,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL
);

CREATE TABLE users (
    id UUID NOT NULL PRIMARY KEY,
    email VARCHAR(254) NOT NULL UNIQUE,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    is_admin VARCHAR(5) NOT NULL,
    joined_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE users_have_collection (
    id_user UUID NOT NULL,
    id_marker UUID NOT NULL,
    PRIMARY KEY (id_user, id_marker),
    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_marker) REFERENCES marker(id)
);

CREATE TABLE items(
	item_id INT AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(100) NOT NULL,
	DESCRIPTION TEXT,
	VALUE INT DEFAULT 0
)

INSERT INTO items(name, DESCRIPTION, VALUE) VALUES
('검', '기본 무기', 10),
('방패', '기본 방어구', 15),
('물약', '체력 회복', 5)

SELECT * FROM items

CREATE TABLE inventories(
	inventory_id INT AUTO_INCREMENT PRIMARY KEY,
	player_id INT,
	item_id INT,
	quantity INT DEFAULT 1,
	FOREIGN KEY(player_id) REFERENCES player(player_id),
	FOREIGN KEY(item_id) REFERENCES items(item_id)
)

INSERT INTO inventories (player_id, item_id, quantity) VALUES
(1,1,1),
(1,3,5),
(2,2,1)

SELECT p.username, i.name, inv.quantity
FROM player p
JOIN inventories inv ON p.player_id = inv.player_id
JOIN items i ON inv.item_id = i.item_id

INSERT INTO items (name, description, value)
VALUES ('마법 지팡이', '마법 공격용 무기', 50);

SELECT * FROM items;

SELECT item_id FROM items WHERE name = '마법 지팡이';

INSERT INTO inventories (player_id, item_id, quantity)
VALUES (1, 4, 1);

SELECT p.username, i.name, inv.quantity
FROM player p
JOIN inventories inv ON p.player_id = inv.player_id
JOIN items i ON inv.item_id = i.item_id

SELECT name, description, value
FROM items
ORDER BY value DESC
LIMIT 1;

CREATE TABLE quests(
	quest_id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	DESCRIPTION TEXT, 
	reward_exp INT DEFAULT 0,
	reward_item_id INT,
	FOREIGN KEY (reward_item_id) REFERENCES items(item_id)
)

INSERT INTO quests(title, DESCRIPTION, reward_exp, reward_item_id) VALUES
('초보자 퀘스트', '첫번째 퀘스트를 완료하세요', 100, 3),
('용사의 검', '전설의 검을 찾아보세요', 500, 1)

CREATE TABLE player_quests(
	player_id INT,
quest_id INT,
STATUS ENUM('시작', '진행중', '완료') DEFAULT '시작',
start_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
completed_at TIMESTAMP NULL,
PRIMARY KEY (player_id, quest_id),
FOREIGN KEY (player_id) REFERENCES player(player_id),
FOREIGN KEY (quest_id) REFERENCES quests(quest_id)
)

INSERT INTO player_quests(player_id, quest_id) VALUES
(1,1),
(2,2)

SELECT p.username, q.title, pq.status
FROM player p
JOIN player_quests pq ON p.player_id = pq.player_id
JOIN quests q ON pq.quest_id = q.quest_id
WHERE pq.`STATUS` != '완료'

UPDATE player_quests
SET STATUS = '완료', completed_at = CURRENT_TIMESTAMP
WHERE player_id = 1 AND quest_id = 1;

INSERT INTO quests (title, description, reward_exp, reward_item_id)
VALUES ('마법사의 도전', '마법 지팡이를 얻기 위한 도전', 800, 4);

SELECT * FROM quests;

SELECT p.username, q.title, pq.status, pq.start_at, pq.completed_at
FROM player p
JOIN player_quests pq ON p.player_id = pq.player_id
JOIN quests q ON pq.quest_id = q.quest_id
WHERE p.player_id = 1;

SELECT title, description, reward_exp
FROM quests
ORDER BY reward_exp DESC
LIMIT 1;

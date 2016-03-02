# Lösche alte vorhandene DB
drop database if exists bank;

# DB Bank anlegen
create database if not exists bank;

# DB auswählen
use bank;

# Tabelle Bank anlegen
create table bank (
	bid int not null auto_increment primary key,
	blz int zerofill not null unique ,
	name varchar(64));

# Datensatz für Banken anlegen
insert into bank (bid, blz, name)
	values ( 1, '12345678', 'Sparkasse Entenhausen'),
	 (2, '67292200', 'Volksbank-Kraichgau');

# Tabelle Peron anlegen	
create table person (
	pid int not null auto_increment primary key,
	bid int not null,
	foreign key(bid) references bank(bid),
	type char(1),
	name varchar(64),
	vorname varchar(64),
	user char(8) unique,
	pw varchar(128));
	
insert into person (pid, bid, type, name, vorname, user, pw)
	values (1, 1, 'K', 'Duck', 'Donald', 'dd', sha2('dd', 512)),
		(2, 1, 'M', 'Duck', 'Dagobert', 'd', sha2('d', 512)),
		(3, 1, 'K', 'Asterix', 'Asterix', 'a', sha2('a', 512));
		
# Tabelle Konto anlegen
create table konto (
	kid bigint(10) zerofill not null  auto_increment primary key,
	pid int not null,
	foreign key(pid) references person(pid),
	bez varchar(64),
	zins decimal(10,2),
	sollzins decimal(10,2),
	stand decimal(10,2),
	datum date);

insert into konto (kid, pid, bez, zins, sollzins, stand, datum)
	values ( 1, 1, 'Giro', 0.1, 10.3, 0, now()),
			(2, 1, 'Bauspar', 0.2, 2, 0, now()),
			(3, 2, 'Giro', 0.2, 8.9, 0, now()),
			(4, 3, 'Giro', 0.1, 10.3, 0, now());
			
# Tabelle Buchung anlegen
create table buchung (
	bu_id int not null auto_increment primary key,
	kid bigint(10) zerofill not null,
	foreign key(kid) references konto(kid),
	uz timestamp,
	empf varchar(128),
	blz int zerofill,
	nr bigint(10) zerofill,
	betrag decimal(10,2),
	zweck varchar(128));
	
insert into buchung(bu_id, kid, uz, empf, blz, nr, betrag, zweck)
	value (1, 1, now(), 'Donald Duck', '12345678', '0000000002', -2000, 'Spare fürs Haus!'),
		(2, 2, now(), 'Donald Duck','12345678', '0000000001', 2000, 'Spare fürs Haus!'),
		(3, 1, now(), 'bar', '12345678', '0000000001', 3456.12, 'Lohn'),
		(4, 1, now(), 'bar', '12345678', '0000000001', -300, 'Geldautomat');  

	
		
		
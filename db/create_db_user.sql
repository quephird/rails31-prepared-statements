-- Run as SYS

create user rails31
identified by rails31
default tablespace users
quota unlimited on users ;

grant create session to rails31 ;
grant create table to rails31 ;
grant create sequence to rails31 ;
grant alter system to rails31 ;

grant select on sys.v_$sqlarea to rails31 ;


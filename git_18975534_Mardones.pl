%=================Dominio================= 

% nombreRepo = string
% AutorRepo = string
% RepoOut = list
% RepoIn = list
% Archivos = list
% Mensaje  = string
% INDEX = list
% LOCAL = list
% REM = list
% local = list
% COMM = list
%==============hechos=====================

%indexZone(INDEX).
%localRepo(LOCAL).
%remoteRepo(REM).
%commit(mensaje,INDEX,COMM).
%repository(NOM,AU,CRAT,repoOut).
%gitInit(NombreRepo,Autor,RepoOut).
%gitAdd(RepoInput, Archivos, RepoOut).
%gitCommit(RepoInput, Mensaje, RepoOutput).
%gitPush(RepoIn,RepoOut).
%git2String(RepoInput, RepoAsString).

%============== metas =====================
% ==== primarias ====

% gitInit
% gitAdd
% gitCommit
% gitPush
% git2String

% ==== Secundarias ====


%=============clausulas====================
%ZONAS 
indexZone([]).
localRepo([]).
remoteRepo([]).

%COMMIT
commit(MSJ,INDEX,[MSJ, INDEX]).

%GITINIT
repository(NOM,AU,CRAT,[NOM,AU,CRAT,INDEX,LOCAL,REM]):-
    indexZone(INDEX),
    localRepo(LOCAL),
    remoteRepo(REM).

gitInit(NOM,AU,RESULT):-
    get_time(X),  
    convert_time(X,CRAT),
    repository(NOM,AU,CRAT,RESULT).
    

%GITADD
gitAdd([NOM,AU,CRAT,INDEX,LOCAL,REM], [] ,[NOM,AU,CRAT,INDEX,LOCAL,REM]).
gitAdd([NOM,AU,CRAT,INDEX,LOCAL,REM], FILE ,[NOM,AU,CRAT,[FILE | INDEX], LOCAL, REM ]).
gitAdd([NOM,AU,CRAT,INDEX,LOCAL,REM], FILE ,[NOM,AU,CRAT,[FILE | INDEX], LOCAL, REM]).

%GITCOMMIT

%caso sin elementos
gitCommit([NOM,AU,CRAT,INDEX,[],REM],MSJ,[NOM,AU,CRAT,[],COMM,REM]):-
    commit(MSJ,INDEX,COMM).
%caso con un elemento
gitCommit([NOM,AU,CRAT,INDEX,[LOCAL],REM],MSJ,[NOM,AU,CRAT,[],[COMM,LOCAL], REM]):-
    commit(MSJ, INDEX, COMM).
%caso con una lista de elementos
gitCommit([NOM,AU,CRAT,INDEX,LOCAL,REM],MSJ,[NOM,AU,CRAT,[],[COMM | LOCAL],REM]):-
    commit(MSJ,INDEX,COMM).

%GITPUSH

%caso sin cambios en local
gitPush([NOM,AU,CRAT,INDEX,[],REM],[NOM,AU,CRAT,INDEX,[],REM]).
%caso sin cambios en remote
gitPush([NOM,AU,CRAT,INDEX,LOCAL,[]],[NOM,AU,CRAT,INDEX,LOCAL,[LOCAL]]).
%caso con cambios en local y remotee
gitPush([NOM,AU,CRAT,INDEX,LOCAL,REM],[NOM,AU,CRAT,INDEX,LOCAL,[LOCAL | REM]]).

% GIT2STRING
git2String([NOM,AU,CRAT,_,_,_], STR):-
    string_concat('####### REPOSITORIO LAB 2 ####### \n rama: ', NOM, S1),
    string_concat('\n Autor:', AU, S2),
    string_concat('\n Fecha de creacion: ',CRAT, S3).
    string_concat(S1,S2,SF),
    string_concat(SF,S3,STR).


% ejemplos

gitInit('master','RodrigoMardones', R1),
gitAdd(R1, 'hello.py', R2),
gitAdd(R2,'hello2.py', R3),
gitCommit(R3,'primer commit', R4),
gitPush(R4,R5),
gitAdd(R5, 'db.csv', R6),
gitCommit(R6,'base de datos guardada',R7),
gitPush(R7,R8),
git2String(R8,STR).
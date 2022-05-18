unit busquedas;

interface

uses
    crt,arch_estancias,arch_provincias;

function busqueda_id_estancia(var arch:f_estancia;buscado:string):integer;
function busqueda_dni(var arch:f_estancia;buscado:longint):integer;
function busqueda_cod_pcia(var arch:f_estancia;buscado:string):integer;

implementation

function busqueda_id_estancia(var arch:f_estancia;buscado:string):integer;
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while not(eof(arch)) and (not encontrado) do
        begin
            read(arch,estancia);
            if estancia.id=buscado then
                begin
                    encontrado:=true;
                end;
        end;
    if encontrado then
        busqueda_id_estancia:=filepos(arch) - 1
    else
        busqueda_id_estancia:=-1;
end;

function busqueda_dni(var arch:f_estancia;buscado:longint):integer;
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while (not eof(arch)) and (not encontrado) do
        begin
            read(arch,estancia);
            if estancia.dni = buscado then
                begin
                    encontrado:=true;
                end;
        end;
        if encontrado then
            busqueda_dni:=filepos(arch) - 1
        else
            busqueda_dni:=-1;
end;

function busqueda_cod_pcia(var arch:f_estancia;buscado:string):integer; {listado}
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while(not eof(arch))and(not encontrado) do
        begin
            read(arch,estancia);
            if estancia.domicilio.cpcia=buscado then
                begin
                    encontrado:=true;
                end;
        end;
        if encontrado then
            busqueda_cod_pcia:=filepos(arch) - 1
        else
            busqueda_cod_pcia:=-1;
end;
end.





















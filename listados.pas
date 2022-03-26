unit listados;

interface
uses
    crt,arch_estancias;

procedure provincia(var arch:f_estancia);
procedure piscina(var arch:f_estancia);
function busqueda_codigo(var arch:f_estancia;buscado:string):integer;

implementation

{para buscar por codigo de la provincia y luego listar}
function busqueda_codigo(var arch:f_estancia;buscado:string):integer;
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while(not eof(arch)) and (not encontrado) do
        begin
            read(arch,estancia);
            encontrado:=estancia.cod_prov = buscado;
        end;
    if encontrado then
        busqueda_codigo:=filepos(arch)-1
    else
        busqueda_codigo:=-1;
end;

procedure provincia(var arch:f_estancia);
var
    i:integer;
    estancia:reg_estancia;
begin
    abrir_estancia(arch);
    gotoxy(23,3);writeln('Ingrese el codigo de la provincia:');
    gotoxy(45,3);readln(estancia.cod_prov);
    i:=busqueda_codigo(arch,estancia.cod_prov);
    if i=-1 then
        begin
            clrscr;
            gotoxy(23,3);writeln('No hay estancias en esa provincia.');   
        end 
    else
        begin
            clrscr;
            gotoxy(23,3);writeln('Listado de las estancias de la provincia con codigo ',estancia.cod_prov,':');
            while not (eof(arch)) do
                begin
                    read(arch,estancia);
                    if (estancia.estado) then
                        begin
                            mostrar_estancia(estancia);
                        end;
                end;
        end;
end;

procedure piscina(var arch:f_estancia);
var
    estancia:reg_estancia;
begin
    abrir_estancia(arch);
    gotoxy(23,3);
    writeln('Listado de las estancias que poseen piscina:');
    while not (eof(arch)) do
        begin
            read(arch,estancia);
            if (estancia.estado) and (estancia.piscina>0) then
                begin
                    mostrar_estancia(estancia);
                end;
        end;
    close(arch);
end;

end.





















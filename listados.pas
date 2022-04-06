unit listados;

interface
uses
    crt,arch_estancias,arch_provincias;

procedure nombre(var arch:f_estancia);
procedure piscina(var arch:f_estancia);
function busqueda_provincia(var arch:f_estancia;buscado:string):integer; {por codigo de la provincia}
procedure provincia(var arch:f_estancia);

implementation

function busqueda_provincia(var arch:f_estancia;buscado:string):integer;
var
    encontrado:boolean;
    estancia:reg_estancia;
begin
    encontrado:=false;
    seek(arch,0);
    while (not eof(arch)) and (not encontrado) do
        begin
            read(arch,estancia);
            encontrado:=estancia.cpcia = buscado
        end;
    if encontrado then
        busqueda_provincia:=filepos(arch)-1
    else
        busqueda_provincia:=-1;
end;

procedure provincia(var arch:f_estancia);
var
    estancia:reg_estancia;
    i,j:integer;
    codigo:string;
begin
    abrir_estancia(arch);
    clrscr;gotoxy(23,3);writeln('Ingrese el codigo de la provincia:');
    gotoxy(57,3);readln(codigo);
    i:=busqueda_provincia(arch,codigo);
    if i=-1 then
        begin
            clrscr;gotoxy(23,3);writeln('No hay una provincia con este codigo.');pulsartecla;
        end
    else
        begin
            gotoxy(23,3);writeln('Listado de las estancias que pertenecen a la provincia con codigo ',codigo);
            for j:=0 to filesize(arch)-1 do
                begin
                    leer_estancia(arch,estancia,j);
                    if (estancia.estado) and (estancia.cpcia=codigo) then
                        begin
                            mostrar_estancia(estancia);
                        end;
                end;
        end;
    close(arch);
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

procedure nombre(var arch:f_estancia);
var
    i:integer;
    estancia:reg_estancia;
begin
    ordenar(arch);
    abrir_estancia(arch);
    gotoxy(23,3);writeln('Listado ordenado alfabeticamente por nombre de la estancia:');
    begin
        for i:=0 to filesize(arch)-1 do
            begin
                leer_estancia(arch,estancia,i);
                if estancia.estado then
                    begin
                        mostrar_estancia(estancia);
                    end;
            end;                
    end;
    close(arch);
end;

end.





















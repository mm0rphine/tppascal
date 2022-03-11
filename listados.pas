unit listados;

interface
uses
    crt,arch_estancias;

procedure nombre(var arch:f_estancia);
procedure piscina(var arch:f_estancia);
procedure orden_alfabetico(var arch:f_estancia);

implementation

procedure orden_alfabetico(var arch:f_estancia);
var
    i,j,lim:integer;
    r1,r2:reg_estancia;
begin
    lim:=filesize(arch)-1;
    for i:=0 to lim-1 do
        begin
            for j:=0  to lim-i do
                begin
                    seek(arch,j);
                    read(arch,r1);
                    seek(arch,j+1);
                    read(arch,r2);
                    if r1.nombre>r2.nombre then
                        begin
                            seek(arch,j+1);
                            write(arch,r1);
                            seek(arch,j);
                            write(arch,r2);
                        end;
                end;
        end;
end;
    
procedure nombre(var arch:f_estancia);
var
    estancia:reg_estancia;
begin
    abrir_estancia(arch);
    orden_alfabetico(arch);
    while not (eof(arch)) do
        begin
            clrscr;
            read(arch,estancia);
            mostrar_estancia(estancia);
        end;
    close(arch);
    readkey;
end;

procedure piscina(var arch:f_estancia);
var
    estancia:reg_estancia;
begin
    abrir_estancia(arch);
    gotoxy(23,3);
    writeln('Listado de las estancias que poseen piscina/s:');
    while not (eof(arch)) do
        begin
            clrscr;
            read(arch,estancia);
            if (estancia.estado) and (estancia.piscina>0) then
                begin
                    mostrar_estancia(estancia);
                end
            else
                begin
                    clrscr;
                    gotoxy(23,6);
                    writeln('No hay estancias con piscina');
                end;
        end;
    close(arch);
    readkey;
end;



end.





















unit listados;

interface
uses
    crt,arch_estancias,arch_provincias;

procedure piscina(var arch:f_estancia);

implementation

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





















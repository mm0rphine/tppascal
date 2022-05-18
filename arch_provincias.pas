unit arch_provincias;

interface
type
    reg_provincia=record
        denom,cod:string;
        telmt:longint;
        estado:boolean;
    end;
    f_provincia=file of reg_provincia;
const
    nombre='provincias.dat';

procedure crear_provincia(var arch:f_provincia);
procedure abrir_provincia(var arch:f_provincia);
procedure leer_provincia(var arch:f_provincia;var reg:reg_provincia;indice:integer);
procedure guardar_provincia(var arch:f_provincia;reg:reg_provincia;indice:integer);
procedure eliminar_provincia(var arch:f_provincia);
procedure alta_provincia(var arch:f_provincia;var reg:reg_provincia);

implementation
uses
    crt,busquedas;

procedure crear_provincia(var arch:f_provincia);
begin
    abrir_provincia(arch);
    if ioresult<>0 then
        begin
            rewrite(arch);
        end;
    close(arch);
end;

procedure abrir_provincia(var arch:f_provincia);
begin
    assign(arch,nombre);
    {$I-}
        reset(arch);
    {$I+}
end;

procedure leer_provincia(var arch:f_provincia;var reg:reg_provincia;indice:integer);
begin
    seek(arch,indice);
    read(arch,reg);
end;

procedure guardar_provincia(var arch:f_provincia;reg:reg_provincia;indice:integer);
begin
    seek(arch,indice);
    write(arch,reg);
end;

procedure alta_provincia(var arch:f_provincia;var reg:reg_provincia);
begin
    clrscr;
    gotoxy(23,3);writeln('Ingrese los datos de la provincia donde se encuentra la estancia');
    gotoxy(23,5);writeln('Cod. Provincia:');
    gotoxy(23,6);writeln('Denominacion:');
    gotoxy(23,7);writeln('Tel. Min. Turismo:');
    gotoxy(39,5);readln(reg.cod);
    gotoxy(37,6);readln(reg.denom);
    gotoxy(37,7);readln(reg.telmt);
end;

procedure eliminar_provincia(var arch:f_provincia);
begin
    erase(arch);
end;
end.

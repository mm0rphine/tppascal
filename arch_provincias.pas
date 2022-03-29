unit arch_provincias;

interface
type
    reg_provincia=record
        denom,cod:string;
        telmt:longint;
    end;
    f_provincia=file of reg_provincia;
const
    nombre='provincias.dat';
var
    file_provincia:f_provincia;

procedure crear_provincia(var arch:f_provincia);
procedure abrir_provincia(var arch:f_provincia);
procedure leer_provincia(var arch:f_provincia;var reg:reg_provincia;indice:integer);
procedure guardar_provincia(var arch:f_provincia;reg:reg_provincia;indice:integer);
procedure alta_provincia(var arch:f_provincia);

implementation
uses
    crt;

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

procedure alta_provincia(var arch:f_provincia);
var
    provincia:reg_provincia;
begin
    clrscr;
    abrir_provincia(arch);
    textcolor(15);
    gotoxy(23,3);writeln('Ingrese los datos de la provincia donde se encuentra la estancia');
    gotoxy(23,5);writeln('Cod. de provincia:');
    gotoxy(23,6);writeln('Provincia:');
    gotoxy(23,7);writeln('Tel. Min. Turismo:');
    gotoxy(41,5);readln(provincia.cod);
    gotoxy(33,6);readln(provincia.denom);
    gotoxy(41,7);readln(provincia.telmt);
    guardar_provincia(arch,provincia,filesize(arch));
    close(arch);        
end;
end.

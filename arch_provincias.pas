unit arch_provincias;

interface
type
    reg_provincia=record
        denom,id,ciudad,calle:string;
        telmt:longint;
        num,piso,cp:integer;
    end;
    f_provincia=file of reg_provincia;
const
    nombre='provincias.dat';
var
    file_provincia:f_provincia;
    provincia:reg_provincia; {global}

procedure crear_provincia(var arch:f_provincia);
procedure abrir_provincia(var arch:f_provincia);
procedure leer_provincia(var arch:f_provincia;var reg:reg_provincia;indice:integer);
procedure guardar_provincia(var arch:f_provincia;reg:reg_provincia;indice:integer);
procedure cargar_provincia(var arch:f_provincia); {carga los datos de la provincia}

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

procedure cargar_provincia(var arch:f_provincia);
begin
    clrscr;
    abrir_provincia(arch);
    textcolor(15);
    gotoxy(23,3);writeln('Ingrese los datos del domicilio donde se encuentra la estancia');
    gotoxy(23,5);writeln('Cod. de la provincia:');
    gotoxy(23,6);writeln('Provincia:');
    gotoxy(23,7);writeln('Ciudad:');
    gotoxy(23,8);writeln('Calle:');
    gotoxy(23,9);writeln('Num.:');
    gotoxy(23,10);writeln('Piso:');
    gotoxy(23,11);writeln('CP:');
    gotoxy(23,12);writeln('Tel. Min. Turismo:');
    gotoxy(45,5);readln(provincia.id);
    gotoxy(40,6);readln(provincia.denom);{provincia}
    gotoxy(42,7);readln(provincia.ciudad);
    gotoxy(35,8);readln(provincia.calle);
    gotoxy(30,9);readln(provincia.num);
    gotoxy(30,10);readln(provincia.piso);
    gotoxy(30,11);readln(provincia.cp);
    gotoxy(40,12);readln(provincia.telmt);
    guardar_provincia(arch,provincia,filesize(arch));
    close(arch);        
end;
end.

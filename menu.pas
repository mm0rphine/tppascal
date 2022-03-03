unit menu;

interface
uses
    crt,arch_estancias,arch_provincias;
var
    file_estancia:f_estancia;
    file_provincia:f_provincia;

procedure principal;
procedure abmc;
procedure listados;
procedure borrar;
procedure dibujo;

implementation

procedure principal;
var
    i,x,y:integer;
    opcion:char;
begin
    crear_estancia(file_estancia);
    repeat
        clrscr;
        textcolor(13);
        x:=15;
        y:=2;
        for i:=1 to 10 do
            begin
                gotoxy(x,y);writeln('|');
                y:=y+1;
            end;
        x:=16;
        y:=1;
        for i:=1 to 13 do
            begin
                gotoxy(x,y);writeln('__');
                x:=x+2;
            end;
        x:=42;
        y:=2;
        for i:= 1 to 10 do
            begin
                gotoxy(x,y);writeln('|');
                y:=y+1;
            end;
        x:=16;
        y:=11;
        for i:=1 to 13 do
            begin
                gotoxy(x,y);writeln('__');
                x:=x+2;
            end;
        textcolor(15);
        gotoxy(22,3);writeln('Menu Principal');
        gotoxy(20,5);writeln('1 ABMC');
        gotoxy(20,6);writeln('2 Listados');
        gotoxy(20,7);writeln('3 Borrar archivos');
        gotoxy(20,8);writeln('4 Salir');
        gotoxy(20,10);writeln('Elija una opcion');
        repeat
            opcion:=readkey;
        until opcion in ['1'..'4'];
        clrscr;
        case opcion of
        '1':abmc;
        '2':listados;
        '3':borrar
        end
    until opcion ='4';
    if opcion='4' then
        begin
            dibujo;
            delay(2100);
            clrscr;
            halt;
        end;
end;    

procedure abmc;
var
   i,x,y:integer;
   opcion:char;
begin
    repeat
        clrscr;
        textcolor(13);
        x:=17;
        y:=3;
        for i:=1 to 11 do
            begin
                gotoxy(x,y);writeln('|');
                y:=y+1;
            end;
        x:=18;
        y:=2;
        for i:=1 to 16 do
            begin
                gotoxy(x,y);writeln('__');
                x:=x+2;
            end;
        x:=50;
        y:=3;
        for i:= 1 to 11 do
            begin
                gotoxy(x,y);writeln('|');
                y:=y+1;
            end;
        x:=18;
        y:=13;
        for i:=1 to 16 do
            begin
                gotoxy(x,y);writeln('__');
                x:=x+2;
            end;
        textcolor(15);
        gotoxy(29,4);writeln('Menu ABMC');
        gotoxy(20,6);writeln('1 Dar de alta una estancia');
        gotoxy(20,7);writeln('2 Dar de baja una estancia');
        gotoxy(20,8);writeln('3 Modificar una estancia');
        gotoxy(20,9);writeln('4 Consultar una estancia');
        gotoxy(20,10);writeln('5 Volver al menu principal');
        gotoxy(25,12);writeln('ELija una opcion');
        repeat
            opcion:=readkey;
        until opcion in ['1'..'5'];
        clrscr;
        case opcion of
        '1':alta_estancia(file_estancia); 
        '2':baja_estancia(file_estancia);
        '3':modificar_estancia(file_estancia);
        '4':consultar_estancia(file_estancia);
        end
    until opcion='5';
    if opcion='5' then
        begin
            principal;
        end;
end;

procedure listados;
var
    opcion:char;
    x,y,i:integer;
begin
    repeat 
        clrscr;
        textcolor(13);
        x:=17;
        y:=3;
        for i:=1 to 10 do
            begin
                gotoxy(x,y);writeln('|');
                y:=y+1;
            end;
        x:=18;
        y:=2;
        for i:=1 to 20 do
            begin
                gotoxy(x,y);writeln('__');
                x:=x+2;
            end;
        x:=58;
        y:=3;
        for i:= 1 to 10 do
            begin
                gotoxy(x,y);writeln('|');
                y:=y+1;
            end;
        x:=18;
        y:=12;
        for i:=1 to 20 do
            begin
                gotoxy(x,y);writeln('__');
                x:=x+2;
            end;
        textcolor(15);
        gotoxy(30,4);writeln('Menu Listados');
        gotoxy(20,6);writeln('1 Listado de estancias por nombre');
        gotoxy(20,7);writeln('2 Listado de estancias por provincia');
        gotoxy(20,8);writeln('3 Estancias que poseen piscinas');
        gotoxy(20,9);writeln('4 Volver al menu principal');
        gotoxy(29,11);writeln('Elija una opcion');
        repeat
            opcion:=readkey;
        until opcion in ['1'..'4'];
        clrscr;
        case opcion of
        '3':listado3(file_estancia);
        end
    until opcion='4';
    if opcion='4' then
        begin
            principal;
        end;
end;

procedure dibujo;
begin
    gotoxy(20,3);
    writeln('(\ /)');
    gotoxy(20,4);
    writeln('( . .)  created by: m0rphine');
    gotoxy(20,5);
    writeln('c(")(")');
end;

procedure borrar;
var
    opcion:char;
begin
        clrscr;
        textcolor(15);
        gotoxy(23,3);writeln('¿Desea borrar los archivos? s/n');
        repeat
            opcion:=readkey;
        until opcion in ['s','n'];
        if opcion = 's' then
            begin
                eliminar(file_estancia);
                clrscr;
                gotoxy(20,6);writeln('Borrando archivos..');
                delay(1500);
                gotoxy(20,6);writeln('Operacion realizada con exito.');
                delay(1000);
                principal;
            end
        else
            begin
                principal;
            end;
end;


end.



unit arch_estancias;

// notas
{terminar archivo provincias}
interface
type
    reg_estancia=record
        id,nombre,dueno,email,caract,cpcia:string;
        dni,tel:longint;
        capacidad,piscina:integer;
        domicilio:record
            ciudad,calle:string;
            num,piso,cp:integer;
        end;
        estado:boolean;
    end;
    f_estancia=file of reg_estancia;
const 
    nombre='estancias.dat';

procedure crear_estancia(var arch:f_estancia);
procedure abrir_estancia(var arch:f_estancia);
procedure leer_estancia(var arch:f_estancia;var reg:reg_estancia;indice:integer);
procedure guardar_estancia(var arch:f_estancia;reg:reg_estancia;indice:integer);
procedure mostrar_estancia(estancia:reg_estancia);
function busqueda_id_estancia(var arch:f_estancia;buscado:string):integer; {secuencial}
function busqueda_dni(var arch:f_estancia;buscado:longint):integer;
procedure alta_estancia(var arch:f_estancia);
procedure baja_estancia(var arch:f_estancia);
procedure modificar_estancia(var arch:f_estancia);
procedure consultar_estancia(var arch:f_estancia);
procedure ordenar(var arch:f_estancia); {orden alfabetico de las estancias}
procedure eliminar_estancia(var arch:f_estancia);
procedure pulsartecla;

implementation
uses
    crt,arch_provincias;

procedure crear_estancia(var arch:f_estancia);
begin
    abrir_estancia(arch);
    if ioresult<>0 then
        begin
            rewrite(arch);
        end;
    close(arch);
end;

procedure abrir_estancia(var arch:f_estancia);
begin
    assign(arch,nombre);
    {$I-}
        reset(arch);
    {$I+}
end;

procedure leer_estancia(var arch:f_estancia;var reg:reg_estancia;indice:integer);
begin
    seek(arch,indice);
    read(arch,reg); {lee los datos del archivo de registro}
end;

procedure guardar_estancia(var arch:f_estancia;reg:reg_estancia;indice:integer); 
begin
    seek(arch,indice);
    write(arch,reg);
end;

procedure pulsartecla;
begin
    gotoxy(16,10);
    textcolor(15);
    writeln('- Pulse cualquier tecla para continuar -');
    readkey;
    clrscr
end;

procedure mostrar_estancia(estancia:reg_estancia); {muestra los datos de la estancia}
begin 
    with estancia do
        begin   
            gotoxy(20,5);writeln('Id de la estancia: ',estancia.id);
            gotoxy(20,6);writeln('Nombre de la estancia: ',estancia.nombre); 
            gotoxy(20,7);writeln('Apellido y nombre del dueño: ',estancia.dueno);
            gotoxy(20,8);writeln('Su DNI es: ',estancia.dni);
            gotoxy(20,9);writeln('Email: ',estancia.email);
            gotoxy(20,10);writeln('Teléfono: ',estancia.tel);
            gotoxy(20,11);writeln('Caracteristicas de la estancia: ',estancia.caract);
            gotoxy(20,12);writeln('Piscinas que posee la estancia: ',estancia.piscina);
            gotoxy(20,13);writeln('Capcidad que posee la estancia: ',estancia.capacidad);
            gotoxy(20,14);writeln('Ciudad: ',estancia.domicilio.ciudad); 
            gotoxy(20,15);writeln('Calle: ',estancia.domicilio.calle);
            gotoxy(20,16);writeln('Numero: ',estancia.domicilio.num);
            gotoxy(20,17);writeln('Piso: ',estancia.domicilio.piso);
            gotoxy(20,18);writeln('CP: ',estancia.domicilio.cp);
            gotoxy(20,21);writeln('- Pulse cualquier tecla para continuar -');readkey;clrscr;
        end;
end;

function busqueda_id_estancia(var arch:f_estancia;buscado:string):integer;
var
    estancia:reg_estancia;
    encontrado:boolean;
begin
    encontrado:=false;
    seek(arch,0);
    while (not eof(arch)) and (not encontrado) do
        begin
            read(arch,estancia);
            encontrado:=estancia.id = buscado
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
            encontrado:=estancia.dni = buscado
        end;
        if encontrado then
            busqueda_dni:=filepos(arch) - 1
        else
            busqueda_dni:=-1;
end;

procedure alta_estancia(var arch:f_estancia);
var
    reg,estancia:reg_estancia;
    r_provincia:reg_provincia;
    archivo_provincias:f_provincia;
    i,x,valdni,valtel,valcap,valpisc,valnum,valpiso,valcp:integer;
    opcion:char;
begin
    clrscr;
    abrir_estancia(arch);
    abrir_provincia(archivo_provincias);
    textcolor(15);
    gotoxy(23,3);writeln('Ingese los datos de la estancia a dar de alta');
    gotoxy(23,5);writeln('Id:');
    gotoxy(23,6);writeln('Nombre:'); 
    gotoxy(23,7);writeln('Dueño:');
    gotoxy(23,8);writeln('DNI:');
    gotoxy(23,9);writeln('Email:');
    gotoxy(23,10);writeln('Tel:');
    gotoxy(23,11);writeln('Cantidad de piscinas:');
    gotoxy(23,12);writeln('Capacidad:');
    gotoxy(23,13);writeln('Caracteristicas:');
    gotoxy(23,14);writeln('Ciudad:');
    gotoxy(23,15);writeln('Calle:');
    gotoxy(23,16);writeln('Numero:');
    gotoxy(23,17);writeln('Piso:');
    gotoxy(23,18);writeln('CP:');
    gotoxy(26,5);readln(estancia.id);
    i:=busqueda_id_estancia(arch,estancia.id);
    if i=-1 then
        begin
            gotoxy(30,6);readln(estancia.nombre);
            gotoxy(29,7);readln(estancia.dueno);
            repeat
                gotoxy(27,8);
                writeln('                   ');
                gotoxy(27,8);
                {$I-}
                    readln(estancia.dni);
                {$I+}
                valdni:=ioresult();
                if valdni=0 then
                    begin
                        x:=busqueda_dni(arch,estancia.dni);
                        if (x>-1) then
                            begin
                                textcolor(12);
                                gotoxy(20,20);writeln('El DNI ingresado ya existe, intente nuevamente.');
                                delay(1800);
                                gotoxy(20,20);writeln('                                               ');
                                textcolor(15);
                            end;
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(1800);
                        gotoxy(20,20);writeln('                                                             ');
                        textcolor(15);
                    end;
            until (x=-1) and (valdni=0);
            gotoxy(29,9);readln(estancia.email);
            repeat
                gotoxy(27,10);
                writeln('                       ');
                gotoxy(27,10);
                {$I-}readln(estancia.tel);{$I+}
                valtel:=ioresult();
                if valtel=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(1800);
                        gotoxy(20,20);writeln('                                                           ');
                        textcolor(15);
                    end;
            until(valtel=0);
            repeat
                gotoxy(44,11);
                writeln('                       ');
                gotoxy(44,11);
                {$I-}readln(estancia.piscina);{$I+}
                valpisc:=ioresult();
                if valpisc=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(1800);
                        gotoxy(20,20);writeln('                                                           ');
                        textcolor(15);
                    end;
            until(valpisc=0);
            repeat
                gotoxy(33,12);
                writeln('                       ');
                gotoxy(33,12);
                {$I-}readln(estancia.capacidad);{$I+}
                valcap:=ioresult();
                if valcap=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(1800);
                        gotoxy(20,20);writeln('                                                             ');
                        textcolor(15);
                    end;
            until(valcap=0);
            gotoxy(39,13);readln(estancia.caract);
            gotoxy(30,14);readln(estancia.domicilio.ciudad);
            gotoxy(29,15);readln(estancia.domicilio.calle);
            repeat
                gotoxy(30,16);
                writeln('                       ');
                gotoxy(30,16);
                {$I-}readln(estancia.domicilio.num);{$I+}
                valnum:=ioresult();
                if valnum=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(1800);
                        gotoxy(20,20);writeln('                                                           ');textcolor(15);
                    end;
            until(valnum=0);
            repeat
                gotoxy(28,17);
                writeln('                           ');
                gotoxy(28,17);
                {$I-}readln(estancia.domicilio.piso);{$I+}
                valpiso:=ioresult();
                if valpiso=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(1800);
                        gotoxy(20,20);writeln('                                                           ');textcolor(15);
                    end;
            until(valpiso=0);
            repeat
                gotoxy(26,18);
                writeln('                           ');
                gotoxy(26,18);
                {$I-}readln(estancia.domicilio.cp);{$I+}
                valcp:=ioresult();
                if valcp=0 then
                    begin
                        break
                    end
                else
                    begin
                        textcolor(12);
                        gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                        delay(1800);
                        gotoxy(20,20);writeln('                                                           ');textcolor(15);
                    end;
            until(valcp=0);
            {cargar datos de la provincia}
            clrscr;
            gotoxy(23,3);writeln('Ingrese los datos de la provincia donde se encuntra la estancia');
            gotoxy(23,5);writeln('Cod. Provincia:');
            gotoxy(23,6);writeln('Denominacion:');
            gotoxy(23,7);writeln('Tel. Min. Turismo:');
            gotoxy(38,5);readln(r_provincia.cod);
            gotoxy(40,6);readln(r_provincia.denom);
            gotoxy(45,7);readln(r_provincia.telmt);
            estancia.cpcia:=r_provincia.cod;
            estancia.estado:=true;
            guardar_estancia(arch,estancia,filesize(arch));
            guardar_provincia(archivo_provincias,r_provincia,filesize(archivo_provincias));
            clrscr;
            textcolor(10);gotoxy(20,6);writeln('La estancia fue dada de alta.');textcolor(15);
            pulsartecla;
        end
    else
        begin
            leer_estancia(arch,reg,i);
            if reg.estado then
                begin
                    clrscr;
                    gotoxy(20,6);textcolor(14);writeln('La estancia con ese id ya existe.');textcolor(15);
                    pulsartecla;
                end
            else
                begin
                    clrscr;
                    gotoxy(20,6);textcolor(14);writeln(' La estancia existe, pero fue dada de baja.');
                    gotoxy(26,8);textcolor(15);writeln('¿Desea darla de alta? s/n');
                    repeat
                        opcion:=readkey;
                    until opcion in ['s','n'];
                    if opcion = 's' then
                        begin
                            leer_estancia(arch,estancia,i);
                            estancia.estado:=true;
                            seek(arch,i);
                            write(arch,estancia);
                            clrscr;
                            gotoxy(20,6);textcolor(10);writeln('La estancia fue dada de alta.');textcolor(15);
                            pulsartecla;
                        end;
                    if opcion ='n' then
                        begin
                            clrscr;
                            gotoxy(20,6);textcolor(12);writeln('La estancia no fue dada de alta.');textcolor(15);
                            pulsartecla;
                        end;
                end;
        end;
    close(arch);
    close(archivo_provincias);
end;

procedure baja_estancia(var arch:f_estancia);
var
    estancia:reg_estancia;
    id:string;
    i:integer;
begin
    clrscr;
    textcolor(15);
    abrir_estancia(arch);
    gotoxy(23,3);writeln('Id de la estancia a dar de baja:');gotoxy(55,3);readln(id);
    i:=busqueda_id_estancia(arch,id);
    if i=-1 then
        begin
            clrscr;
            gotoxy(20,6);textcolor(12);writeln('No existe una estancia con ese id.');textcolor(15);
            pulsartecla;
        end
    else
        begin
            leer_estancia(arch,estancia,i);
            if estancia.estado then
                begin
                    estancia.estado:=false;
                    i:=filepos(arch) - 1;
                    guardar_estancia(arch,estancia,i);
                end;
            clrscr;
            gotoxy(20,6);textcolor(10);writeln('La estancia fue dada de baja.');textcolor(15);
            pulsartecla;
        end;
    close(arch);
end;

procedure modificar_estancia(var arch:f_estancia);
var
    id:string;
    i,valdni,valtel,valpisc,valcap,valnum,valpiso,valcp:integer;
    estancia:reg_estancia;
begin
    abrir_estancia(arch);
    clrscr;
    gotoxy(20,3);writeln('Id de la estancia a modificar:');gotoxy(50,3);readln(id);
    i:=busqueda_id_estancia(arch,id);
    if i=-1 then
        begin
            clrscr;
            gotoxy(20,6);textcolor(12);writeln('No existe una estancia con ese id.');textcolor(15);
            pulsartecla;
        end
    else
        begin
            leer_estancia(arch,estancia,i);
            if estancia.estado then
                begin
                    clrscr;
                    gotoxy(23,3);writeln('Ingrese los nuevos datos de la estancia');
                    gotoxy(23,6);writeln('Nombre:');
                    gotoxy(23,7);writeln('Dueño:');
                    gotoxy(23,8);writeln('DNI:');
                    gotoxy(23,9);writeln('Email:');
                    gotoxy(23,10);writeln('Tel:');
                    gotoxy(23,11);writeln('Cantidad de piscinas:');
                    gotoxy(23,12);writeln('Capacidad:');
                    gotoxy(23,13);writeln('Caracteristicas:');
                    gotoxy(23,14);writeln('Ciudad:');
                    gotoxy(23,15);writeln('Calle:');
                    gotoxy(23,16);writeln('Numero:');
                    gotoxy(23,17);writeln('Piso:');
                    gotoxy(23,18);writeln('CP:');
                    gotoxy(30,6);readln(estancia.nombre); 
                    gotoxy(29,7);readln(estancia.dueno);         
                    repeat
                        gotoxy(27,8);
                        writeln('                   ');
                        gotoxy(27,8);
                        {$I-}
                            readln(estancia.dni);
                        {$I+}
                        valdni:=ioresult();
                        if valdni=0 then
                            begin
                                break
                            end
                        else
                            begin
                                textcolor(12);
                                gotoxy(20,16);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                delay(1800);
                                gotoxy(20,16);writeln('                                                           ');
                                textcolor(15);
                            end;
                    until (valdni=0);
                    gotoxy(29,9);readln(estancia.email);
                    repeat
                        gotoxy(27,10);writeln('                     ');
                        gotoxy(27,10);{$I-}readln(estancia.tel);{$I+}
                        valtel:=ioresult();
                        if valtel=0 then
                            begin
                                break
                            end
                        else
                            begin
                                textcolor(12);
                                gotoxy(20,16);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                delay(1800);
                                gotoxy(20,16);writeln('                                                           ');
                                textcolor(15);
                            end;
                    until (valtel=0); 
                    repeat
                        gotoxy(44,11);writeln('           ');
                        gotoxy(44,11);{$I-}readln(estancia.piscina);{$I+}
                        valpisc:=ioresult();
                        if valpisc=0 then
                            begin
                                break
                            end
                        else
                            begin
                                textcolor(12);
                                gotoxy(20,16);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                delay(1800);
                                gotoxy(20,16);writeln('                                                           ');
                                textcolor(15);
                            end;
                    until (valpisc=0);
                    repeat
                        gotoxy(33,12);writeln('               ');
                        gotoxy(33,12);{$I-}readln(estancia.capacidad);{$I+}
                        valcap:=ioresult();
                        if valcap=0 then
                            begin
                                break
                            end
                        else
                            begin
                                textcolor(12);
                                gotoxy(20,16);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                delay(1800); 
                                gotoxy(20,16);writeln('                                                             ');
                                textcolor(15);
                            end;
                    until valcap=0;
                    gotoxy(39,13);readln(estancia.caract);
                    gotoxy(30,14);readln(estancia.domicilio.ciudad);
                    gotoxy(29,15);readln(estancia.domicilio.calle);
                    repeat
                        gotoxy(30,16);
                        writeln('                       ');
                        gotoxy(30,16);
                        {$I-}readln(estancia.domicilio.num);{$I+}
                        valnum:=ioresult();
                        if valnum=0 then
                            begin
                                break
                            end
                        else
                            begin
                                textcolor(12);
                                gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                delay(1800);
                                gotoxy(20,20);writeln('                                                           ');textcolor(15);
                            end;
                    until(valnum=0);
                    repeat
                        gotoxy(28,17);
                        writeln('                           ');
                        gotoxy(28,17);
                        {$I-}readln(estancia.domicilio.piso);{$I+}
                        valpiso:=ioresult();
                        if valpiso=0 then
                            begin
                                break
                            end
                        else
                            begin
                                textcolor(12);
                                gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                delay(1800);
                                gotoxy(20,20);writeln('                                                           ');textcolor(15);
                            end;
                    until(valpiso=0);
                    repeat
                        gotoxy(26,18);
                        writeln('                           ');
                        gotoxy(26,18);
                        {$I-}readln(estancia.domicilio.cp);{$I+}
                        valcp:=ioresult();
                        if valcp=0 then
                            begin
                                break
                            end
                        else
                            begin
                                textcolor(12);
                                gotoxy(20,20);writeln('El tipo de dato ingresado no es valido, intente nuevamente.');
                                delay(1800);
                                gotoxy(20,20);writeln('                                                           ');textcolor(15);
                            end;
                    until(valcp=0);
                    i:=filepos(arch) - 1;
                    guardar_estancia(arch,estancia,i);
                    clrscr;
                    gotoxy(20,6);textcolor(10);writeln('Los datos fueron modificados.');textcolor(15);
                    pulsartecla;
                end
            else
                begin
                    clrscr;
                    gotoxy(13,6);textcolor(14);writeln('La estancia fue dada de baja, debe darla de alta.');textcolor(15);
                    pulsartecla;
                end;
        end;
    close(arch);
end;

procedure consultar_estancia(var arch:f_estancia);
var
    estancia:reg_estancia;
    id:string;
    i:integer;
begin
    abrir_estancia(arch);
    clrscr;
    textcolor(15);
    gotoxy(20,3);writeln('Id de la estancia a consultar:');gotoxy(50,3);readln(id);
    i:=busqueda_id_estancia(arch,id);
    if i=-1 then
        begin
            clrscr;
            gotoxy(20,6);textcolor(12);writeln('No existe una estancia con ese id.');textcolor(15);
            pulsartecla;
        end
    else
        begin
            leer_estancia(arch,estancia,i);
            if estancia.estado then
                begin
                    clrscr;
                    gotoxy(20,3);writeln('Los datos de la estancia consultada son los siguientes:');
                    mostrar_estancia(estancia);
                end
            else
                begin
                    clrscr;
                    gotoxy(13,6);textcolor(14);writeln('La estancia fue dada de baja, debe darla de alta.');textcolor(15);
                    pulsartecla;
                end;
        end;
    close(arch);
end;

procedure ordenar(var arch:f_estancia);
var
    estancia,aux_estancia,tmp:reg_estancia;
    i,j:integer;
begin
    abrir_estancia(arch); 
    for i:= 0 to filesize(arch)-1 do
        begin
            seek(arch,i);
            read(arch,estancia);
            for j:=filesize(arch) - 1 downto i + 1 do 
                begin
                    seek(arch,j);
                    read(arch,aux_estancia);
                    if estancia.nombre>aux_estancia.nombre then
                        begin
                            tmp:=estancia;
                            estancia:=aux_estancia;
                            aux_estancia:=tmp;
                            seek(arch,i);
                            write(arch,estancia);
                            seek(arch,j);
                            write(arch,aux_estancia);
                        end;
                end;
        end;
    close(arch);
end;

procedure eliminar_estancia(var arch:f_estancia);
begin
    erase(arch);
end;

end.

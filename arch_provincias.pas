unit arch_provincias;

interface
type
    reg_provincia=record
        denom,cod_provincia:string;
        telmt:longint;
    end;
    f_provincia=file of reg_provincia;
    const
        nombre='provincias.dat';

procedure crear_provincia(var arch:f_provincia);
procedure abrir_provincia(var arch:f_provincia);

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
end.

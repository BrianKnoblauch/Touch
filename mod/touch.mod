MODULE touch;

FROM Environment    IMPORT GetCommandLine;
FROM FileFunc       IMPORT CloseFile,CreateFile,File,FileExists,SetFileDateTime;
FROM STextIO        IMPORT WriteLn,WriteString;
FROM SysClock       IMPORT DateTime,GetClock;

VAR
    args    : ARRAY [0..8192] OF CHAR;
    dt      : DateTime;
    success : BOOLEAN;
    f       : File;

BEGIN
    GetCommandLine(args);
    IF args[0] = CHR(0) THEN
        WriteString("Touch usage: supply filename to either be created or have timestamp updated.");
        WriteLn;
    ELSE
        IF FileExists(args) THEN
            GetClock(dt);
            success := SetFileDateTime(args, dt);
            IF NOT success THEN
                WriteString("Unable to update existing file.");
                WriteLn;
            END;
        ELSE
            CreateFile(f, args);
            CloseFile(f);
        END;
    END;
END touch.

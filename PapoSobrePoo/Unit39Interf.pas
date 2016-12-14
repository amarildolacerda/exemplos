unit Unit39Interf;

interface

type
  IMinhaInterface = interface
    ['{A240A96D-4201-4A41-82D1-4C09C9EBED18}']
    function GetCaption: string;
    procedure SetCaption(const AValue: string);
    property Caption: string Read GetCaption write SetCaption;
    function _RefCount: integer;
  end;


implementation

end.

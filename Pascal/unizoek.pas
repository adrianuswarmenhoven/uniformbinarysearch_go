Program Algorithm;

{ Uniform binary search.
  Algorithm C on page 412 of "The Art of Computer Programming"
  volume 3 / "Sorting and Searching" by Donald E. Knuth. }

const
  N = 70;
  R = 5;
  delta : array[1..16] of word =
  (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

var
  m, g : word;
  rij : array[0..N] of word;
  ok : boolean;

procedure Maak_delta;

var
  lgN, j : byte;
  h, macht, mini : word;

begin
  lgN := 0;
  h := N;
  while h > 0 do
  begin
    h := h shr 1;
    lgN := lgN + 1;
  end;
  lgN := lgN - 1;
  macht := 1;
  for j := 1 to (lgN+2) do
  begin
    mini := macht;
    macht := macht shl 1;
    delta[j] := (N + mini) div macht;
  end;
end;

function UniSearch : boolean;

var
  i, j : word;

begin

  rij[0] := 0;

  i := delta[1];
  j := 2;

  repeat

    if g < rij[i] then
    begin
      if delta[j] = 0 then
      begin
        UniSearch := false;
        Exit;
      end;
      i := i - delta[j];
      j := j + 1;
      Continue;
    end;
    if g > rij[i] then
    begin
      if delta[j] = 0 then
      begin
        UniSearch := false;
        Exit;
      end;
      i := i + delta[j];
      j := j + 1;
      Continue;
    end;
    if g = rij[i] then
    begin
      UniSearch := true;
      Exit;
    end;

  until false;

end;

begin
  m := 1;
  rij[1] := Random(R) + 5;
  for m := 2 to N do
  begin
    Write(rij[m-1],' ');
    rij[m] := rij[m-1] + Random(R);
  end;
  Writeln(rij[N]);

  Maak_delta;

  g := 2; { special }
  for m := 1 to 15 do
  begin
    ok := UniSearch;
    if ok then
      Writeln(g,' : found')
    else
      Writeln(g,' : not found');
    g := Random(N);
  end;
end.
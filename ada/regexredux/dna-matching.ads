pragma Source_Reference (000164, "regexredux.gnat");


package DNA.Matching is

   procedure Count_Matches (Seq : U.String_Access; Limit : Positive);

   function Get (Variant : Variant_Index) return Natural;

end DNA.Matching;

pragma Source_Reference (000173, "regexredux.gnat");

package DNA.Replacing is
   Number_Of_Tasks : constant Positive := 4;

   procedure Perform_Replacements
     (Limit      : Positive;
      New_Length : out Natural);
end DNA.Replacing;

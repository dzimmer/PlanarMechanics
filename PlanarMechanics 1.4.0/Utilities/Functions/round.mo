within PlanarMechanics.Utilities.Functions;
function round "Round to nearest Integer"
  extends Modelica.Icons.Function;

  input Real v "Real number";
  output Integer i "Real number v rounded to nearest integer";

algorithm
  i :=if v >= 0 then integer(floor(v + 0.5)) else integer(ceil(v - 0.5));
  annotation (Documentation(info="<html>
<p>
Returns the input argument rounded to the nearest Integer. Examples:
</p>
 
<pre>
   round(2.4)  ->  2
   round(2.6)  ->  3
   round(-1.3) -> -1
   round(-1.6) -> -2
</pre>
</html>", revisions="<html>
<table border=0 cellspacing=0 cellpadding=0>
  <tr><td valign=\"center\"> <img src=\"modelica://PowerTrain/Resources/Images/dlr_logo.png\" ></td>
      <td valign=\"center\"> <b>Copyright &copy; DLR Institute of System Dynamics and Control<b> </td>
  </tr>
 </table>
</html>"));
end round;

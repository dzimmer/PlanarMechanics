within PlanarMechanics.VehicleComponents;
package Wheels 
annotation (Documentation(info="<html>
<p>This package contains wheel models that roll on the x,y plane. The wheel models are hereby represented as a mass-free element similar to a joint component.</p>
</html>", revisions="<html>
<p><img src=\"./Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
          {100,100}}), graphics={        Rectangle(
          extent={{-80,100},{100,-80}},
          lineColor={0,0,0},
          fillColor={215,230,240},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-100,80},{80,-100}},
          lineColor={0,0,0},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{-80,62},{60,-78}},
        lineColor={0,0,0},
        fillColor={215,215,215},
        fillPattern=FillPattern.Sphere),
      Ellipse(
        extent={{-60,40},{40,-58}},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None),
      Ellipse(
        extent={{-20,2},{0,-18}},
        lineColor={0,0,255},
        fillPattern=FillPattern.Solid,
        fillColor={0,0,0})}));
end Wheels;

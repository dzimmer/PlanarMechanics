within PlanarMechanics.Sources.Translational;
model Accelerate
  "Forced movement of a flange according to an acceleration signal"

  parameter Boolean useSupport = false
    "= true, if support flange enabled, otherwise implicitly grounded"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  SI.Velocity v(start=0, fixed=true, stateSelect=StateSelect.prefer)
    "Absolute velocity of flange_b";
  SI.Acceleration a "Absolute acceleration of flange_b";

  Modelica.Mechanics.Translational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{90,-10},
            {110,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a support(s = s_support) if useSupport
    "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Blocks.Interfaces.RealInput a_ref
    "Absolute acceleration of flange as input signal"
     annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
          rotation=0)));
  Modelica.SIunits.Length s(start=0, fixed=true, stateSelect=StateSelect.prefer)
    "Distance between flange and support (= flange.s - support.s)";
protected
  Modelica.SIunits.Length s_support "Absolute position of support flange";
equation
  if not useSupport then
    s_support = 0;
  end if;
  s = flange.s - s_support;
  v = der(s);
  a = der(v);
  a = a_ref;
  annotation (
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>
The input signal <b>a</b> in [m/s2] moves the 1D translational flange
connector flange_b with a predefined <i>acceleration</i>, i.e., the flange
is <i>forced</i> to move relative to the support connector  with this acceleration. The velocity and the
position of the flange are also predefined and are determined by
integration of the acceleration.
</p>
<p>
The acceleration \"a(t)\" can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Source.
</p>

</html>"), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-56,-40},{-166,-68}},
          lineColor={0,0,0},
          textString="a_ref"),
        Line(points={{-30,-32},{30,-32}}, color={0,0,0}),
        Line(visible=useSupport,points={{0,-32},{0,-100}}, color={0,0,0}),
        Line(points={{30,-42},{20,-52}}, color={0,0,0}),
        Line(points={{30,-32},{10,-52}}, color={0,0,0}),
        Line(points={{20,-32},{0,-52}}, color={0,0,0}),
        Line(points={{10,-32},{-10,-52}}, color={0,0,0}),
        Line(points={{0,-32},{-20,-52}}, color={0,0,0}),
        Line(points={{-10,-32},{-30,-52}}, color={0,0,0}),
        Line(points={{-20,-32},{-30,-42}}, color={0,0,0}),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{-29,32},{30,32}}, color={0,0,0}),
        Line(points={{0,52},{0,32}}, color={0,0,0}),
        Text(
          extent={{150,60},{-150,100}},
          textString="%name",
          lineColor={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics));
end Accelerate;

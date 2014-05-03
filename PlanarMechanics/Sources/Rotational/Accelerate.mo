within PlanarMechanics.Sources.Rotational;
model Accelerate
  "Forced movement of a flange according to an acceleration signal"
  import SI = Modelica.SIunits;

  parameter Boolean useSupport = false
    "= true, if support flange enabled, otherwise implicitly grounded"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  SI.Angle phi(start=0, fixed=true, stateSelect=StateSelect.prefer)
    "Rotation angle of flange with respect to support";
  SI.AngularVelocity w(start=0, fixed=true, stateSelect=StateSelect.prefer)
    "Angular velocity of flange with respect to support";
  SI.AngularAcceleration a
    "Angular acceleration of flange with respect to support";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{90,-10},
            {110,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support(phi = phi_support) if useSupport
    "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Blocks.Interfaces.RealInput a_ref
    "Absolute angular acceleration of flange with respect to support as input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  Modelica.SIunits.Angle phi_support "Absolute angle of support flange";

equation
  if not useSupport then
    phi_support = 0;
  end if;

  phi = flange.phi - phi_support;
  w = der(phi);
  a = der(w);
  a = a_ref;
  annotation (
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>
The input signal <b>a</b> defines an <b>angular acceleration</b>
in [rad/s2]. Flange <b>flange</b> is <b>forced</b> to move relative to flange support with
this acceleration. The angular velocity <b>w</b> and the rotation angle
<b>phi</b> of the flange are automatically determined by integration of
the acceleration.
</p>
<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>

</html>"), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{-30,-32},{30,-32}}, color={0,0,0}),
        Line(points={{0,52},{0,32}}, color={0,0,0}),
        Line(points={{-29,32},{30,32}}, color={0,0,0}),
        Line(visible=useSupport,points={{0,-32},{0,-100}}, color={0,0,0}),
        Line(points={{30,-42},{20,-52}}, color={0,0,0}),
        Line(points={{30,-32},{10,-52}}, color={0,0,0}),
        Line(points={{20,-32},{0,-52}}, color={0,0,0}),
        Line(points={{10,-32},{-10,-52}}, color={0,0,0}),
        Line(points={{0,-32},{-20,-52}}, color={0,0,0}),
        Line(points={{-10,-32},{-30,-52}}, color={0,0,0}),
        Line(points={{-20,-32},{-30,-42}}, color={0,0,0}),
        Text(
          extent={{-46,-50},{-144,-86}},
          lineColor={0,0,0},
          textString="a_ref"),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          lineColor={0,0,255})}));
end Accelerate;

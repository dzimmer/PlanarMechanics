within PlanarMechanics.Sources.Rotational;
model Speed
  "Forced movement of a flange according to a reference angular velocity signal"
  import SI = Modelica.SIunits;

  parameter Boolean useSupport = false
    "= true, if support flange enabled, otherwise implicitly grounded"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter Boolean exact=false
    "true/false exact treatment/filtering the input signal";
  parameter SI.Frequency f_crit=50
    "if exact=false, critical frequency of filter to filter input signal";
  SI.Angle phi(start=0, fixed=true, stateSelect=StateSelect.prefer)
    "Rotation angle of flange with respect to support";
  SI.AngularVelocity w(stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "Angular velocity of flange with respect to support";
  SI.AngularAcceleration a
    "If exact=false, angular acceleration of flange with respect to support else dummy";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{90,-10},
            {110,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support(phi = phi_support) if useSupport
    "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Blocks.Interfaces.RealInput w_ref
    "Reference angular velocity of flange with respect to support as input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

protected
  Modelica.SIunits.Angle phi_support "Absolute angle of support flange";
  parameter Modelica.SIunits.AngularFrequency w_crit=2*Modelica.Constants.pi*f_crit
    "Critical frequency";
initial equation
  if not exact then
    w = w_ref;
  end if;
equation
  if not useSupport then
    phi_support = 0;
  end if;

  phi = flange.phi - phi_support;
  w = der(phi);
  if exact then
    w = w_ref;
    a = 0;
  else
    // Filter: a = w_ref/(1 + (1/w_crit)*s)
    a = der(w);
    a = (w_ref - w)*w_crit;
  end if;
  annotation (
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>
The input signal <b>w_ref</b> defines the <b>reference
speed</b> in [rad/s]. Flange <b>flange</b> is <b>forced</b>
to move relative to flange support according to this reference motion. According to parameter
<b>exact</b> (default = <b>false</b>), this is done in the following way:
<ol>
<li><b>exact=true</b><br>
    The reference speed is treated <b>exactly</b>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least once. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal once
    in order to compute the reference acceleration of the flange.</li>
<li><b>exact=false</b><br>
    The reference angle is <b>filtered</b> and the second derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This second derivative is <b>not</b> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a first order filter is used.
    The critical frequency (also called cut-off frequency) of the
    filter is defined via parameter <b>f_crit</b> in [Hz]. This value
    should be selected in such a way that it is higher as the essential
    low frequencies in the signal.</li>
</ol>
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
        Line(points={{-30,-32},{30,-32}}),
        Line(points={{0,52},{0,32}}),
        Line(points={{-29,32},{30,32}}),
        Line(visible=useSupport,points={{0,-32},{0,-100}}),
        Line(points={{-10,-32},{-30,-52}}),
        Line(points={{0,-32},{-20,-52}}),
        Line(points={{10,-32},{-10,-52}}),
        Line(points={{20,-32},{0,-52}}),
        Line(points={{-20,-32},{-30,-42}}),
        Line(points={{30,-32},{10,-52}}),
        Line(points={{30,-42},{20,-52}}),
        Text(
          extent={{-54,-44},{-158,-78}},
          lineColor={0,0,0},
          textString="w_ref"),
        Text(
          extent={{0,120},{0,60}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{146,-26},{30,-60}},
          lineColor={0,0,0},
          textString="exact="),
        Text(
          extent={{146,-62},{30,-96}},
          lineColor={0,0,0},
          textString="%exact")}));
end Speed;

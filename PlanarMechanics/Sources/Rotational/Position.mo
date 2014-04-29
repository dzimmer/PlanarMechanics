within PlanarMechanics.Sources.Rotational;
model Position
  "Forced movement of a flange according to a reference angle signal"
  import SI = Modelica.SIunits;

  parameter Boolean useSupport = false
    "= true, if support flange enabled, otherwise implicitly grounded"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean exact=false
    "true/false exact treatment/filtering the input signal"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  parameter SI.Frequency f_crit=50
    "if exact=false, critical frequency of filter to filter input signal" annotation(Dialog(enable=not exact));
  SI.Angle phi(stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "Rotation angle of flange with respect to support";
  SI.AngularVelocity w(start=0,stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "If exact=false, Angular velocity of flange with respect to support else dummy";
  SI.AngularAcceleration a(start=0)
    "If exact=false, Angular acceleration of flange with respect to support else dummy";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{90,-10},
            {110,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support(phi = phi_support) if useSupport
    "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Blocks.Interfaces.RealInput phi_ref(final quantity="Angle", final unit="rad", displayUnit="deg")
    "Reference angle of flange with respect to support as input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
          rotation=0)));
protected
  Modelica.SIunits.Angle phi_support "Absolute angle of support flange";
  parameter Modelica.SIunits.AngularFrequency w_crit=2*Modelica.Constants.pi*f_crit
    "Critical frequency";
  constant Real af=1.3617 "s coefficient of Bessel filter";
  constant Real bf=0.6180 "s*s coefficient of Bessel filter";

initial equation
  if not exact then
    flange.phi = phi_ref;
  end if;

equation
  if not useSupport then
    phi_support = 0;
  end if;
  phi = flange.phi - phi_support;
  if exact then
    flange.phi = phi_ref;
    w = 0;
    a = 0;
  else
    // Filter: a = phi_ref*s^2/(1 + (af/w_crit)*s + (bf/w_crit^2)*s^2)
    w = der(flange.phi);
    a = der(w);
    a = ((phi_ref - flange.phi)*w_crit - af*w)*(w_crit/bf);
  end if;
  annotation (
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<HTML>
<p>
The input signal <b>phi_ref</b> defines the <b>reference
angle</b> in [rad]. Flange <b>flange</b> is <b>forced</b>
to move according to this reference motion relative to flange support. According to parameter
<b>exact</b> (default = <b>false</b>), this is done in the following way:
<ol>
<li><b>exact=true</b><br>
    The reference angle is treated <b>exactly</b>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least twice. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal twice
    in order to compute the reference acceleration of the flange.</li>
<li><b>exact=false</b><br>
    The reference angle is <b>filtered</b> and the second derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This second derivative is <b>not</b> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a second order Bessel filter is used.
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
          filuseSupportlPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{-30,-32},{30,-32}}, color={0,0,0}),
        Line(points={{0,52},{0,32}}, color={0,0,0}),
        Line(points={{-29,32},{30,32}}, color={0,0,0}),
        Line(visible=useSupport, points={{0,-32},{0,-100}}, color={0,0,0}),
        Line(points={{30,-42},{20,-52}}, color={0,0,0}),
        Line(points={{30,-32},{10,-52}}, color={0,0,0}),
        Line(points={{20,-32},{0,-52}}, color={0,0,0}),
        Line(points={{10,-32},{-10,-52}}, color={0,0,0}),
        Line(points={{0,-32},{-20,-52}}, color={0,0,0}),
        Line(points={{-10,-32},{-30,-52}}, color={0,0,0}),
        Line(points={{-20,-32},{-30,-42}}, color={0,0,0}),
        Text(
          extent={{-56,-56},{-172,-90}},
          lineColor={0,0,0},
          textString="phi_ref"),
        Text(
          extent={{150,60},{-150,100}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{146,-28},{30,-62}},
          lineColor={0,0,0},
          textString="exact="),
        Text(
          extent={{146,-64},{30,-98}},
          lineColor={0,0,0},
          textString="%exact")}));
end Position;

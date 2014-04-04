within PlanarMechanics.Sources.Translational;
model Position "Forced movement of a flange according to a reference position"

  parameter Boolean useSupport = false
    "= true, if support flange enabled, otherwise implicitly grounded"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

  parameter Boolean exact=false
    "true/false exact treatment/filtering the input signal";
  parameter SI.Frequency f_crit=50
    "if exact=false, critical frequency of filter to filter input signal" annotation(Dialog(enable=not exact));
  SI.Velocity v(start=0, stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "If exact=false, absolute velocity of flange_b else dummy";
  SI.Acceleration a(start=0)
    "If exact=false, absolute acceleration of flange_b else dummy";

  Modelica.Mechanics.Translational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{90,-10},
            {110,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a support(s = s_support) if useSupport
    "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput s_ref
    "Reference position of flange as input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
  Modelica.SIunits.Length s(stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "Distance between flange and support (= flange.s - support.s)";

protected
  Modelica.SIunits.Length s_support "Absolute position of support flange";
  parameter Modelica.SIunits.AngularFrequency w_crit=2*Modelica.Constants.pi*f_crit
    "Critical frequency";
  constant Real af=1.3617 "s coefficient of Bessel filter";
  constant Real bf=0.6180 "s*s coefficient of Bessel filter";

initial equation
  if not exact then
    s = s_ref;
  end if;
equation
  if not useSupport then
    s_support = 0;
  end if;
  s = flange.s - s_support;
  if exact then
    s = s_ref;
    v = 0;
    a = 0;
  else
    // Filter: a = s_ref*S^2/(1 + (af/w_crit)*S + (bf/w_crit^2)*S^2)
    v = der(s);
    a = der(v);
    a = ((s_ref - s)*w_crit - af*v)*(w_crit/bf);
  end if;
  annotation (
    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<HTML>
<p>
The input signal <b>s_ref</b> defines the <b>reference
position</b> in [m]. Flange <b>flange_b</b> is <b>forced</b>
to move relative to the support connector according to this reference motion. According to parameter
<b>exact</b> (default = <b>false</b>), this is done in the following way:
<ol>
<li><b>exact=true</b><br>
    The reference position is treated <b>exactly</b>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least twice. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal twice
    in order to compute the reference acceleration of the flange.</li>
<li><b>exact=false</b><br>
    The reference position is <b>filtered</b> and the second derivative
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

</HTML>
"), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-56,-36},{-178,-66}},
          lineColor={0,0,0},
          textString="s_ref"),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,127,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{150,60},{-150,100}},
          textString="%name",
          lineColor={0,0,255}),
        Line(points={{0,52},{0,32}}, color={0,0,0}),
        Line(points={{-29,32},{30,32}}, color={0,0,0}),
        Line(points={{-30,-32},{30,-32}}, color={0,0,0}),
        Line(visible=useSupport,points={{0,-32},{0,-100}}, color={0,0,0}),
        Line(points={{30,-42},{20,-52}}, color={0,0,0}),
        Line(points={{30,-32},{10,-52}}, color={0,0,0}),
        Line(points={{20,-32},{0,-52}}, color={0,0,0}),
        Line(points={{10,-32},{-10,-52}}, color={0,0,0}),
        Line(points={{0,-32},{-20,-52}}, color={0,0,0}),
        Line(points={{-10,-32},{-30,-52}}, color={0,0,0}),
        Line(points={{-20,-32},{-30,-42}}, color={0,0,0}),
        Text(
          extent={{144,-30},{30,-60}},
          lineColor={0,0,0},
          textString="exact="),
        Text(
          extent={{134,-68},{22,-96}},
          lineColor={0,0,0},
          textString="%exact")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics));
end Position;

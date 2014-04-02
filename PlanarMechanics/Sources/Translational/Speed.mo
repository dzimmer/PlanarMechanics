within PlanarMechanics.Sources.Translational;
model Speed "Forced movement of a flange according to a reference speed"

  parameter Boolean useSupport = false
    "= true, if support flange enabled, otherwise implicitly grounded"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

  parameter Boolean exact=false
    "true/false exact treatment/filtering the input signal";
  parameter SI.Frequency f_crit=50
    "if exact=false, critical frequency of filter to filter input signal" annotation(Dialog(enable=not exact));
  SI.Velocity v(stateSelect=if exact then StateSelect.default else StateSelect.prefer)
    "Absolute velocity of flange_b";
  SI.Acceleration a
    "If exact=false, absolute acceleration of flange_b else dummy";

  Modelica.Mechanics.Translational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{90,-10},
            {110,10}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a support(s = s_support) if useSupport
    "Support/housing of component"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Modelica.Blocks.Interfaces.RealInput v_ref
    "Reference speed of flange as input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
  Modelica.SIunits.Length s(start=0, fixed=true, stateSelect=StateSelect.prefer)
    "Distance between flange and support (= flange.s - support.s)";

protected
  Modelica.SIunits.Length s_support "Absolute position of support flange";
  parameter Modelica.SIunits.AngularFrequency w_crit=2*Modelica.Constants.pi*f_crit
    "Critical frequency";
initial equation
  if not exact then
    v = v_ref;
  end if;
equation
  if not useSupport then
    s_support = 0;
  end if;
  s = flange.s - s_support;
  v = der(s);
  if exact then
    v = v_ref;
    a = 0;
  else
    // Filter: a = v_ref/(1 + (1/w_crit)*s)
    a = der(v);
    a = (v_ref - v)*w_crit;
  end if;
  annotation (
    Documentation(revisions="<html><p><img src=\"./Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  revisions="<html><p><img src=\"./Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<HTML>
<p>
The input signal <b>v_ref</b> defines the <b>reference
speed</b> in [m/s]. Flange <b>flange_b</b> is <b>forced</b>
to move relative to the support connector  according to this reference motion. According to parameter
<b>exact</b> (default = <b>false</b>), this is done in the following way:
<ol>
<li><b>exact=true</b><br>
    The reference speed is treated <b>exactly</b>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least once. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal once
    in order to compute the reference acceleration of the flange.</li>
<li><b>exact=false</b><br>
    The reference speed is <b>filtered</b> and the first derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This first derivative is <b>not</b> computed by
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

</HTML>
"), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-54,-36},{-174,-68}},
          lineColor={0,0,0},
          textString="v_ref"),
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
          lineColor={0,0,255}),
        Text(
          extent={{146,-38},{32,-64}},
          lineColor={0,0,0},
          textString="exact="),
        Text(
          extent={{140,-76},{22,-102}},
          lineColor={0,0,0},
          textString="%exact")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics));
end Speed;

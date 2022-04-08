within PlanarMechanics.VehicleComponents;
model AirResistanceLongitudinal "Velocity dependent longitudinal air resistance"

  parameter Real c_W(min=0, start=0.5) "Drag coefficient";
  parameter SI.Area area(min=0, start=2) "Frontal cross area of vehicle";
  parameter SI.Density rho = 1.18 "Air density";
  parameter SI.Length r[2] = {1,0} "Driving direction of vehicle at angle frame_a.phi = 0";

  SI.Velocity vAir[2]
    "Air velocity relative to vehicle (vAir = -v_veh + v_wind), resolved in frame_a";
  SI.Force fDrag "Scalar drag force";

protected
  SI.Force f_long "Air force acting in x-direction of frame_a, resolved in frame_a";
  SI.Velocity v_wind_0[2] "Wind velocity, resolved in inertial frame";
  SI.Velocity v0[2] "Velocity resolved in inertial frame";
  constant SI.Velocity v_eps = 1e-3
    "Minimum vehicle velocity to apply this air drag model";
  final parameter Real e[2](each final unit="1") = Modelica.Math.Vectors.normalizeWithAssert(r)
    "Unit vector in direction of r";
  Real R[2,2] "Rotation matrix";
  Real R0a[2,2] "Rotation matrix from inertial frame to frame_a";
  Real Rae[2,2] "Rotation matrix from frame_a to e";

public
  Interfaces.Frame_a frame_a annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));

equation
  R0a = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
  Rae = {{e[1], -e[2]}, {e[2], e[1]}};
  R = R0a*Rae;

  // Vehicle environment
  v_wind_0=zeros(2); //atmosphere.windVelocity(frame_a.r_0);
  v0 = der({frame_a.x,frame_a.y});

  // Air velocity resolved in frame_a
  vAir = transpose(R)*( -v0 + v_wind_0);

  // Force and torque
  fDrag = 0.5*area*rho*vAir[1]*vAir[1]*c_W;
  f_long = noEvent(if vAir[1] > -v_eps then 0 else fDrag);
  {frame_a.fx, frame_a.fy} = R*{f_long, 0};
  frame_a.t = 0;

  annotation (
    Documentation(
      info="<html>
<p>
The vehicle&apos;s air drag, resolved in <code>frame_a</code>, is calculated as:
</p>
<blockquote><pre>
fDrag = ( c_W *  area * rho * v_x^2 ) / 2
</pre></blockquote>
<p>where: </p>
<blockquote><pre>
c_W           : air drag coefficient,
area          : cross area of vehicle,
rho           : density of the air,
v_x = vAir[1] : longitudinal component of air velocity, resolved in frame_a.
</pre></blockquote>
<p>
Just air drag in vehicle&apos;s longitudinal direction is calculated here,
which can be specified for <code>frame_a.phi&nbsp;=&nbsp;0</code> by the
parameter&nbsp;<code>r</code>.
For example for <code>r&nbsp;=&nbsp;{1,&nbsp;0}</code> the driving direction is in
x-direction of <code>frame_a</code> and, thus, <code>frame_a.fx&nbsp;= fDrag</code>.
The other forces and torque are disregarded.
</p>

<h4>Note</h4>
<p>
This model is limited to negative air velocity <code>v_x</code> only.
For positive velocity, which can occur e.g. when driving rearwards,
the air drag is set to zero.
</p>
</html>"),
    Diagram(
      coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}})),
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-96,40},{80,-40}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-60,20},{-60,-20},{-80,0},{-60,20}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),
        Polygon(
          points={{-62,6},{-62,-6},{-60,-6},{-44,0},{-22,-10},{-6,-10},{20,0},{42,-10},{58,-10},{74,-2},{74,-2},{74,10},{74,10},{50,0},{28,10},{12,10},{-14,0},{-38,10},{-50,10},{-60,6},{-62,6}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Text(
          extent={{-100,-30},{100,-60}},
          textColor={0,0,0},
          textString="cw = %c_W"),
        Text(
          extent={{-150,80},{150,40}},
          textString="%name",
          textColor={0,0,255})}));
end AirResistanceLongitudinal;

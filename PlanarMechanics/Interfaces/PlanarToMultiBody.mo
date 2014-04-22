within PlanarMechanics.Interfaces;
model PlanarToMultiBody
  "This model enables to connect planar models to 3D Models"

  Frame_a frame_a "Frame connector in Planarmechanics"
                                                      annotation (Placement(transformation(extent={{-46,-8},{-26,12}}),
        iconTransformation(extent={{-48,-20},{-8,20}})));
  MB.Interfaces.Frame_b frame_b "Frame connector in MultiBody" annotation (Placement(transformation(extent={{6,
            -16},{38,16}}), iconTransformation(extent={{8,-16},{40,16}})));
protected
  SI.Force fz "Normal Force";
  SI.Force f0[3] "Force vector";
equation
  //connect the translatory position w.r.t inertial system
  frame_a.x = frame_b.r_0[1];
  frame_a.y = frame_b.r_0[2];
  0 = frame_b.r_0[3];
  //Express 3D-rotation as planar rotation around z-axes
  MB.Frames.planarRotation({0,0,1},frame_a.phi, der(frame_a.phi)) = frame_b.R;
  //define force vector
  f0 = {frame_a.fx, frame_a.fy, fz};
  //the MulitBody force vector is resolved within the body system
  f0*frame_b.R.T + frame_b.f = zeros(3);
  //connect the torque
  frame_a.t + frame_b.t[3] = 0;
  //This element determines the orientation matrix fully, hence it is a "root-element"
  Connections.root(frame_b.R);
  annotation (Icon(graphics={Line(
          points={{-18,0},{16,0}},
          color={95,95,95},
          smooth=Smooth.None,
          thickness=0.5)}),    Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",  info="<html>
<p>This component enables the connection between Planarmechanics and <a href=\"Modelica://Modelica.Mechanics.MultiBody\">MultiBody</a>.</p>
</html>"));
end PlanarToMultiBody;

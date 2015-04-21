within PlanarMechanics.Interfaces;
model PlanarToMultiBody
  "This model enables to connect planar models to 3D Models"
  parameter SI.Length zPosition = planarWorld.defaultZPosition
    "Position z of cylinder representing the fixed translation" annotation (Dialog(
      tab="Animation", group="if animation = true", enable=animate));
  outer PlanarWorld planarWorld "planar world model";
  Frame_a frame_a "Frame connector in Planarmechanics"
    annotation (Placement(transformation(extent={{-46,-8},{-26,12}}),
        iconTransformation(extent={{-60,-20},{-20,20}})));
  MB.Interfaces.Frame_b frame_b "Frame connector in MultiBody" annotation (Placement(transformation(extent={{6,
            -16},{38,16}}), iconTransformation(extent={{24,-16},{56,16}})));
protected
  SI.Force fz "Normal Force";
  SI.Force f0[3] "Force vector";
equation
  //connect the translatory position w.r.t inertial system
  frame_b.r_0 = MB.Frames.resolve1(planarWorld.R,{frame_a.x,frame_a.y,zPosition})+planarWorld.r_0;

  //Express 3D-rotation as planar rotation around z-axes
  frame_b.R = MB.Frames.absoluteRotation(planarWorld.R,MB.Frames.planarRotation({0,0,1},frame_a.phi, der(frame_a.phi)));
  //define force vector in inertial system
  f0 = MB.Frames.resolve1(planarWorld.R,{frame_a.fx, frame_a.fy, fz});
  //the MulitBody force vector is resolved within the body system
  f0*frame_b.R.T + frame_b.f = zeros(3);
  //connect the torque
  frame_a.t + MB.Frames.resolve2(planarWorld.R,frame_b.t)*{0,0,1} = 0;
  //This element determines the orientation matrix fully, hence it is a "root-element"
  Connections.root(frame_b.R);

  annotation (Icon(coordinateSystem(extent={{-40,-20},{40,20}},
          preserveAspectRatio=false),
                   graphics={Line(
          points={{-36,0},{38,0}},
          color={95,95,95},
          thickness=1)}),      Documentation(revisions="<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",  info="<html>
<p>This component enables the connection between Planarmechanics and <a href=\"Modelica://Modelica.Mechanics.MultiBody\">MultiBody</a>.</p>
<p>The orientation and position of the 2D system within the 3D system are determined by the Multi-Body connector of the planar world model or zero rotation at zero position otherwise</p>
<p>The physical connection assumes the 2D world to be the root of the system, defining the orientation. All forces and torques acting outside the plane are assumed to be absorbed by the planar world system.. Beware! These forces are not transmitted by the Multi-Body connector of the planar world.</p>
</html>"),
    Diagram(coordinateSystem(extent={{-40,-20},{40,20}})));
end PlanarToMultiBody;

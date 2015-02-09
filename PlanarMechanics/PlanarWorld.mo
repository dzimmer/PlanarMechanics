within PlanarMechanics;
model PlanarWorld
  "Planar world coordinate system + gravity field + default animation definition"

  MB.Interfaces.Frame_a MBFrame_a if connectToMultiBody
    annotation (Placement(transformation(extent={{-118,-16},{-86,16}})));

  SI.Position r_0[3]
    "Position vector from world frame to the connector frame origin, resolved in world frame";
  MB.Frames.Orientation R
    "Orientation object to rotate the world frame into the connector frame";

  parameter Boolean inheritGravityFromMultiBody = false
    "=true if gravity vector shall be inherited from 3D world model"                                                     annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true),Dialog(group="Gravity"));

  parameter SI.Acceleration[2] constantGravity={0,-9.81}
    "Constant gravity acceleration vector resolved in world frame" annotation(Dialog(group="Gravity",enable = not inheritGravityFromMultiBody));

    parameter Boolean connectToMultiBody = false
    "= true when visualization of the planar world shall be connected to a 3D multibody system"
                                                                                                        annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true),Dialog(group="Animation (General)"));

  parameter Boolean enableAnimation=true
    "= true, if animation of all components is enabled" annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true),Dialog(group="Animation (General)"));
  parameter Boolean animateWorld=true
    "= true, if world coordinate system shall be visualized" annotation (
    HideResult=true,
    choices(checkBox=true),Dialog(group="Animation (General)",enable=enableAnimation));
  parameter Boolean animateGravity=true
    "= true, if gravity field shall be visualized (acceleration vector or field center)"
                                                                                         annotation (
    HideResult=true,
    choices(checkBox=true),Dialog(group="Animation (General)",enable=enableAnimation));
  parameter String label1="x" "Label of horizontal axis in icon" annotation(Dialog(group="Animation (General)"));
  parameter String label2="y" "Label of vertical axis in icon" annotation(Dialog(group="Animation (General)"));
  SI.Acceleration[2] g
    "Constant gravity acceleration vector resolved in world frame";

  parameter SI.Length axisLength=nominalLength/2 "Length of world axes arrows"
    annotation (Dialog(tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  parameter SI.Diameter axisDiameter=axisLength/defaultFrameDiameterFraction
    "Diameter of world axes arrows"
    annotation (Dialog(tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  parameter Boolean axisShowLabels=true "= true, if labels shall be shown"
    annotation (Dialog(tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  input Types.Color axisColor_x=Types.Defaults.FrameColor "Color of x-arrow"
    annotation (HideResult = true, Dialog(colorSelector=true,tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  input Types.Color axisColor_y=axisColor_x "Coler of y-arrow"
    annotation (HideResult = true, Dialog(colorSelector=true,tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  input Types.Color axisColor_z=axisColor_x "Color of z-arrow"
    annotation (HideResult = true, Dialog(colorSelector=true,tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));

  parameter SI.Position gravityArrowTail[2]={0,0}
    "Position vector from origin of world frame to arrow tail, resolved in world frame"
    annotation (Dialog(tab="Animation", group=
          "if animateGravity = true and gravityType = UniformGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
  parameter SI.Length gravityArrowLength=axisLength/2 "Length of gravity arrow"
    annotation (Dialog(tab="Animation", group=
          "if animateGravity = true and gravityType = UniformGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
  parameter SI.Diameter gravityArrowDiameter=gravityArrowLength/
      defaultWidthFraction "Diameter of gravity arrow" annotation (Dialog(tab=
          "Animation", group="if animateGravity = true and gravityType = UniformGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
  input Types.Color gravityArrowColor={0,230,0} "Color of gravity arrow" annotation (HideResult = true, Dialog(colorSelector=true,tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));

  parameter SI.Length defaultZPosition=0
    "Default for z positions of all the elements"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length nominalLength=1 "\"Nominal\" length of PlanarMechanics"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultJointLength=nominalLength/10
    "Default for the fixed length of a shape representing a joint"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultJointWidth=nominalLength/10
    "Default for the fixed width of a shape representing a joint"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Diameter defaultBodyDiameter=nominalLength/9
    "Default for diameter of sphere representing the center of mass of a body"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultWidthFraction=20
    "Default for shape width as a fraction of shape length (e.g., for Parts.FixedTranslation)"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Diameter defaultArrowDiameter=nominalLength/40
    "Default for arrow diameter (e.g., of forces, torques, sensors)"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultForceLength=nominalLength/10
    "Default for the fixed length of a shape representing a force (e.g., damper)"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultForceWidth=nominalLength/20
    "Default for the fixed width of a shape represening a force (e.g., spring, bushing)"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultFrameDiameterFraction=40
    "Default for arrow diameter of a coordinate system as a fraction of axis length"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultSpecularCoefficient(min=0) = 0.7
    "Default reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultN_to_m(unit="N/m", min=0) = 1000
    "Default scaling of force arrows (length = force/defaultN_to_m)"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultNm_to_m(unit="N.m/m", min=0) = 1000
    "Default scaling of torque arrows (length = torque/defaultNm_to_m)"
    annotation (Dialog(tab="Defaults"));

protected
  MB.Interfaces.Frame MBFrame;

  outer Modelica.Mechanics.MultiBody.World world;

  SI.Acceleration gz "auxiliary gravity acc. in z-direction";

  parameter Integer ndim=if enableAnimation and animateWorld then 1 else 0;
  parameter Integer ndim2=if enableAnimation and animateWorld and
      axisShowLabels then 1 else 0;

  // Parameters to define axes
  parameter SI.Length headLength=min(axisLength, axisDiameter*Types.Defaults.
      FrameHeadLengthFraction);
  parameter SI.Length headWidth=axisDiameter*Types.Defaults.
      FrameHeadWidthFraction;
  parameter SI.Length lineLength=max(0, axisLength - headLength);
  parameter SI.Length lineWidth=axisDiameter;

  // Parameters to define axes labels
  parameter SI.Length scaledLabel=Modelica.Mechanics.MultiBody.Types.Defaults.FrameLabelHeightFraction*
      axisDiameter;
  parameter SI.Length labelStart=1.05*axisLength;

  // x-axis
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape x_arrowLine(
    shapeType="cylinder",
    length=lineLength,
    width=lineWidth,
    height=lineWidth,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    color=axisColor_x,
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape x_arrowHead(
    shapeType="cone",
    length=headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    color=axisColor_x,
    r={lineLength,0,0},
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines x_label(
    lines=scaledLabel*{[0, 0; 1, 1],[0, 1; 1, 0]},
    diameter=axisDiameter,
    color=axisColor_x,
    r_lines={labelStart,0,0},
    n_x={1,0,0},
    n_y={0,1,0},
    specularCoefficient=0) if enableAnimation and animateWorld and axisShowLabels;

  // y-axis
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape y_arrowLine(
    shapeType="cylinder",
    length=lineLength,
    width=lineWidth,
    height=lineWidth,
    lengthDirection={0,1,0},
    widthDirection={1,0,0},
    color=axisColor_y,
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape y_arrowHead(
    shapeType="cone",
    length=headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection={0,1,0},
    widthDirection={1,0,0},
    color=axisColor_y,
    r={0,lineLength,0},
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines y_label(
    lines=scaledLabel*{[0, 0; 1, 1.5],[0, 1.5; 0.5, 0.75]},
    diameter=axisDiameter,
    color=axisColor_y,
    r_lines={0,labelStart,0},
    n_x={0,1,0},
    n_y={-1,0,0},
    specularCoefficient=0) if enableAnimation and animateWorld and axisShowLabels;

  // z-axis
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape z_arrowLine(
    shapeType="cylinder",
    length=lineLength,
    width=lineWidth,
    height=lineWidth,
    lengthDirection={0,0,1},
    widthDirection={0,1,0},
    color=axisColor_z,
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape z_arrowHead(
    shapeType="cone",
    length=headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection={0,0,1},
    widthDirection={0,1,0},
    color=axisColor_z,
    r={0,0,lineLength},
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines z_label(
    lines=scaledLabel*{[0, 0; 1, 0],[0, 1; 1, 1],[0, 1; 1, 0]},
    diameter=axisDiameter,
    color=axisColor_z,
    r_lines={0,0,labelStart},
    n_x={0,0,1},
    n_y={0,1,0},
    specularCoefficient=0) if enableAnimation and animateWorld and axisShowLabels;

  // gravity visualization
  parameter SI.Length gravityHeadLength=min(gravityArrowLength,
      gravityArrowDiameter*Types.Defaults.ArrowHeadLengthFraction);
  parameter SI.Length gravityHeadWidth=gravityArrowDiameter*Types.Defaults.ArrowHeadWidthFraction;
  parameter SI.Length gravityLineLength=max(0, gravityArrowLength - gravityHeadLength);
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravityArrowLine(
    shapeType="cylinder",
    length=gravityLineLength,
    width=gravityArrowDiameter,
    height=gravityArrowDiameter,
    lengthDirection={g[1],g[2],0},
    widthDirection={0,1,0},
    color=gravityArrowColor,
    r_shape={gravityArrowTail[1],gravityArrowTail[2],0},
    specularCoefficient=0) if enableAnimation and animateGravity;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravityArrowHead(
    shapeType="cone",
    length=gravityHeadLength,
    width=gravityHeadWidth,
    height=gravityHeadWidth,
    lengthDirection={g[1],g[2],0},
    widthDirection={0,1,0},
    color=gravityArrowColor,
    r_shape={gravityArrowTail[1],gravityArrowTail[2],0} + Modelica.Math.Vectors.normalize({g[1],g[2],0})*gravityLineLength,
    specularCoefficient=0) if enableAnimation and animateGravity;

equation
  if connectToMultiBody then
    connect(MBFrame_a,MBFrame);
  else
    MBFrame.r_0 = {0,0,0};
    MBFrame.R = MB.Frames.nullRotation();
//    Connections.root(MBFrame.R);

  end if;

  r_0 = MBFrame.r_0;
  R = MBFrame.R;

  if inheritGravityFromMultiBody then
    {g[1],g[2],gz} = MB.Frames.resolve2(R,world.gravityAcceleration(MBFrame.r_0));
  else
    gz = 0;
    g = constantGravity;
  end if;
//  MBFrame.f = {0,0,0};
//  MBFrame.t = {0,0,0};

    annotation (
    defaultComponentName="planarWorld",
    defaultComponentPrefixes="inner",
    missingInnerMessage="No \"world\" component is defined. A default world
component with the default gravity field will be used
(g=9.81 in negative y-axis). If this is not desired,
drag PlanarMechanics.PlanarWorld into the top level of your model.",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-118},{-100,61}},
          thickness=0.5),
        Polygon(
          points={{-100,100},{-120,60},{-80,60},{-100,100},{-100,100}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-119,-100},{59,-100}},
          thickness=0.5),
        Polygon(
          points={{99,-100},{59,-80},{59,-120},{99,-100}},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,145},{150,105}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{95,-113},{144,-162}},
          textString="%label1"),
        Text(
          extent={{-170,127},{-119,77}},
          textString="%label2"),
        Line(points={{-56,60},{-56,-26}}, color={0,0,255}),
        Polygon(
          points={{-68,-8},{-56,-48},{-44,-8},{-68,-8}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{2,60},{2,-26}}, color={0,0,255}),
        Polygon(
          points={{-10,-8},{2,-48},{14,-8},{-10,-8}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{66,60},{66,-26}}, color={0,0,255}),
        Polygon(
          points={{54,-8},{66,-48},{78,-8},{54,-8}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-80,90},{80,60}},
          lineColor={0,0,0},
          textString="2-dim."),
        Text(
          extent={{-100,-50},{100,-80}},
          lineColor={0,0,0},
          textString="g=%constantGravity")}),
    Documentation(
      revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b></p></html>",
      info="<html>
<p>Model <b>PlanarWorld</b> defines all possible general parameters to make parameterization of models much more conveniant. It has the following functionalites.</p>
<ol>
<li>It defines the global coordinate system fixed in ground and show x, y, z axises in animation if wanted.</li>
<li>It contains all default parameters for animation, e.g. axis diameter, default joint length etc, which can still be overwritten by setting parameters in these models.</li>
<li>It provides the default gravity definition and its animation.</li>
</ol>
<p><br>The planar world can optionaly be coupled to a <a href=\"Modelica.Mechanics.MultiBody.Interfaces.Frame_a\">3D-Multibody connector</a>. This will affect visualization mainly. Beware! The physics of the planar world presume the inertial system to be non-accelerated. When connecting to an accelerated MultiBody connector the physical forces going along with this acceleration are thus neglected.</p>
<p>For physical coupling between 2D and 3D system use <a href=\"PlanarMechanics.Interfaces.PlanarToMultiBody\">Interfaces.PlanarToMultiBody</a></p>
<p>The gravity vector can be inherited from the <a href=\"Modelica.Mechanics.MultiBody.World\">MultiBody world component</a>. In this case, the vector is determined once for the origin of the planar world system and then applied to all body components (if enabled there, as default). </p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end PlanarWorld;

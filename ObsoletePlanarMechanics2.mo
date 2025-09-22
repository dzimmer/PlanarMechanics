within ;
package ObsoletePlanarMechanics2 "Library that contains components from PlanarMechanics Library 1.6.0 that have been removed from version 2.0.0"
  extends Modelica.Icons.Package;

  package Sources "Sources to drive 2D mechanical components"
    extends Modelica.Icons.SourcesPackage;

    model RelativeForce "Input signal acting as force and torque on two frames"
      extends PlanarMechanics.Interfaces.PartialTwoFrames;
      extends Modelica.Icons.ObsoleteModel;

      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a
        "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
      parameter Boolean animation=true "= true, if animation shall be enabled";

      parameter Real N_to_m(unit="N/m") = planarWorld.defaultN_to_m
        "Force arrow scaling (length = force/N_to_m)"
        annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));
      parameter Real Nm_to_m(unit="N.m/m") = planarWorld.defaultNm_to_m
        "Torque arrow scaling (length = torque/Nm_to_m)"
        annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));

      parameter Modelica.Units.SI.Length zPosition=planarWorld.defaultZPosition "Position z of cylinder representing the fixed translation" annotation (Dialog(
          tab="Animation",
          group="If animation = true",
          enable=animation));
      input Modelica.Mechanics.MultiBody.Types.Color color=PlanarMechanics.Types.Defaults.ForceColor "Color of arrow" annotation (HideResult=true, Dialog(
          tab="Animation",
          group="If animation = true",
          colorSelector=true,
          enable=animation));
      input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient=planarWorld.defaultSpecularCoefficient "Reflection of ambient light (= 0: light is completely absorbed)" annotation (HideResult=true, Dialog(
          tab="Animation",
          group="If animation = true",
          enable=animation));

      Modelica.Blocks.Interfaces.RealInput force[3]
        annotation (Placement(transformation(extent={{-20,-20},{20,20}}, origin={-60,-120}, rotation=90)));

      Real R[2,2] "Rotation matrix from world frame to frame_b";
      Modelica.Units.SI.Angle phi "Rotation angle of the additional frame_c";

      PlanarMechanics.Interfaces.Frame_resolve frame_resolve(
        fx=0,
        fy=0,
        t=0,
        phi=phi) if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve "Coordinate system in which vector is optionally resolved, if useExtraFrame is true" annotation (Placement(transformation(
            extent={{-16,-16},{16,16}},
            rotation=90,
            origin={40,-100})));

    protected
      Modelica.Units.SI.Position f_in_m[3]={force[1],force[2],0}/N_to_m "Force mapped from N to m for animation";
      Modelica.Units.SI.Position t_in_m[3]={0,0,force[3]}/Nm_to_m "Torque mapped from N.m to m for animation";
      Modelica.Mechanics.MultiBody.Frames.Orientation R_0=Modelica.Mechanics.MultiBody.Frames.absoluteRotation(
          planarWorld.R,
          Modelica.Mechanics.MultiBody.Frames.planarRotation(
            {0,0,1},
            phi,
            der(phi)));
      Modelica.Units.SI.Position rvisobj[3]=Modelica.Mechanics.MultiBody.Frames.resolve1(planarWorld.R, {frame_b.x,frame_b.y,zPosition}) + planarWorld.r_0;

      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector arrowForce(
        coordinates=f_in_m,
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj,
        quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force,
        headAtOrigin=true,
        R=R_0) if planarWorld.enableAnimation and animation;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector arrowTorque(
        coordinates=t_in_m,
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj,
        quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque,
        headAtOrigin=true,
        R=planarWorld.R) if planarWorld.enableAnimation and animation;

    equation
      if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a then
        phi = frame_a.phi;
        //R = {{cos(frame_a.phi), -sin(frame_a.phi)}, {sin(frame_a.phi),cos(frame_a.phi)}};
      elseif resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b then
        phi = frame_b.phi;
        //R = {{cos(frame_b.phi), -sin(frame_b.phi)}, {sin(frame_b.phi),cos(frame_b.phi)}};
        //R = {{cos(frame_resolve.phi), -sin(frame_resolve.phi)}, {sin(frame_resolve.phi),cos(frame_resolve.phi)}};
      elseif resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.world then
        phi = 0;
      end if;
        R = {{cos(phi), -sin(phi)}, {sin(phi),cos(phi)}};
        {frame_b.fx, frame_b.fy} + R * {force[1], force[2]} = {0, 0};
        frame_b.t + force[3] = 0;

        frame_a.fx + frame_b.fx = 0;
        frame_a.fy + frame_b.fy = 0;
        frame_a.t + frame_b.t = 0;

      annotation (
        obsolete = "Obsolete model - use PlanarMechanics.Sources.RelativeForce instead",
        Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
            Line(
              points={{30,0},{30,-100}},
              color={95,95,95},
              pattern=LinePattern.Dot),
            Line(
              points={{-60,-100},{30,-100}},
              color={95,95,95},
              pattern=LinePattern.Dot),
            Polygon(
              points={{14,10},{44,10},{44,40},{94,0},{44,-40},{44,-10},{14,-10},{14,10}},
              lineColor={0,127,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-14,10},{-44,10},{-44,40},{-94,0},{-44,-40},{-44,-10},{-14,-10},{-14,10}},
              lineColor={0,127,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,110},{150,70}},
              textString="%name",
              textColor={0,0,255}),
            Text(
              extent={{-108,-24},{-72,-49}},
              textColor={128,128,128},
              textString="a"),
            Text(
              extent={{72,-24},{108,-49}},
              textColor={128,128,128},
              textString="b")}),
        Documentation(
          info="<html>
<p>
Obsolete model of the <strong>3</strong> signals of the <strong>force</strong> connector which
contains force and torque.
This model is only provided for backward compatibility &ndash; use
<a href=\"modelica://PlanarMechanics.Sources.RelativeForce\">PlanarMechanics.Sources.RelativeForce</a>
instead.
</p>
<p>
Note: the input connectors were changed. Instead of <code>force[3]</code>,
there are <code>force[2]</code> and <code>torque</code> in
<a href=\"modelica://PlanarMechanics.Sources.RelativeForce\">PlanarMechanics.Sources.RelativeForce</a>
now. Consequently, the obsolete usage like
</p>
<blockquote><pre>
  <font style=\"color:red;font-family:courier;\">ObsoletePlanarMechanics2.Sources.RelativeForce</font> relativeForce1;
  <font style=\"color:red;font-family:courier;\">ObsoletePlanarMechanics2.Sources.RelativeForce</font> relativeForce2;
  Whatever.Signal.Source1 signal[3];
  Whatever.Signal.Source2 signal_yVec;
  ...
<strong>equation</strong>
  <strong>connect</strong>(signal.y, relativeForce1.force);
  <strong>connect</strong>(signal_yVec.y, relativeForce2.force);
  ...
</pre></blockquote>
<p>
shall be changed to
</p>
<blockquote><pre>
  
  <font style=\"color:#cc00ff;font-family:courier;\">PlanarMechanics.Sources.RelativeForce</font> relativeForce1;
  <font style=\"color:#cc00ff;font-family:courier;\">PlanarMechanics.Sources.RelativeForce</font> relativeForce2;
  Whatever.Signal.Source1 signal[3];
  Whatever.Signal.Source2 signal_yVec;
  ...
<strong>equation</strong>
  <strong>connect</strong>(signal<font style=\"color:#cc00ff;font-family:courier;\">[1:2]</font>.y, relativeForce1.force);
  <strong>connect</strong>(signal<font style=\"color:#cc00ff;font-family:courier;\">[3]</font>.y, relativeForce1.<font style=\"color:#cc00ff;font-family:courier;\">torque</font>);
  <strong>connect</strong>(signal_yVec.y<font style=\"color:#cc00ff;font-family:courier;\">[1:2]</font>, relativeForce2.force);
  <strong>connect</strong>(signal_yVec.y<font style=\"color:#cc00ff;font-family:courier;\">[3]</font>, relativeForce2.<font style=\"color:#cc00ff;font-family:courier;\">torque</font>);
  ...
</pre></blockquote>
<p>
Optionally, especially for graphical modeling, a&nbsp;<a href=\"modelica://Modelica.Blocks.Routing.DeMultiplex3\">DeMultiplexer</a>
can be used instead to split source signals.
</p>
</html>
",        revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
    end RelativeForce;

    model WorldForce "External force and torque acting at frame_b, defined by 3 input signals and resolved in world frame"
      extends Modelica.Icons.ObsoleteModel;

      outer PlanarMechanics.PlanarWorld planarWorld "Planar world model";

      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b
        "Frame in which output vector r_rel shall be resolved (1: world, 2: frame_b, 3: frame_resolve)";
      parameter Boolean animation=true "= true, if animation shall be enabled";

      parameter Real N_to_m(unit="N/m") = planarWorld.defaultN_to_m
        "Force arrow scaling (length = force/N_to_m)"
        annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));
      parameter Real Nm_to_m(unit="N.m/m") = planarWorld.defaultNm_to_m
        "Torque arrow scaling (length = torque/Nm_to_m)"
        annotation (Dialog(tab="Animation",group="If animation = true", enable=animation));

      parameter Modelica.Units.SI.Length zPosition=planarWorld.defaultZPosition "Position z of cylinder representing the fixed translation" annotation (Dialog(
          tab="Animation",
          group="If animation = true",
          enable=animation));
      input Modelica.Mechanics.MultiBody.Types.Color color=PlanarMechanics.Types.Defaults.ForceColor "Color of arrow" annotation (HideResult=true, Dialog(
          tab="Animation",
          group="If animation = true",
          colorSelector=true,
          enable=animation));
      input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient=planarWorld.defaultSpecularCoefficient "Reflection of ambient light (= 0: light is completely absorbed)" annotation (HideResult=true, Dialog(
          tab="Animation",
          group="If animation = true",
          enable=animation));

      PlanarMechanics.Interfaces.Frame_b frame_b "Coordinate system fixed to the component with one cut-force and cut-torque" annotation (Placement(transformation(extent={{84,-16},{116,16}})));

      Modelica.Blocks.Interfaces.RealInput force[3]
        "x-, y-coordinates of force and torque resolved in world frame"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

      PlanarMechanics.Interfaces.Frame_resolve frame_resolve(
        fx=0,
        fy=0,
        t=0,
        phi=phi) if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve "Coordinate system in which vector is optionally resolved, if useExtraFrame is true" annotation (Placement(transformation(
            extent={{-16,-16},{16,16}},
            rotation=90,
            origin={0,-100})));

      Real R[2,2] "Rotation matrix from world frame to frame_b";
      Modelica.Units.SI.Angle phi "Rotation angle of the additional frame_c";

    protected
      Modelica.Units.SI.Position f_in_m[3]={force[1],force[2],0}/N_to_m "Force mapped from N to m for animation";
      Modelica.Units.SI.Position t_in_m[3]={0,0,force[3]}/Nm_to_m "Torque mapped from N.m to m for animation";
      Modelica.Mechanics.MultiBody.Frames.Orientation R_0=Modelica.Mechanics.MultiBody.Frames.absoluteRotation(
          planarWorld.R,
          Modelica.Mechanics.MultiBody.Frames.planarRotation(
            {0,0,1},
            phi,
            der(phi)));
      Modelica.Units.SI.Position rvisobj[3]=Modelica.Mechanics.MultiBody.Frames.resolve1(planarWorld.R, {frame_b.x,frame_b.y,zPosition}) + planarWorld.r_0;

      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector arrowForce(
        coordinates=f_in_m,
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj,
        quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force,
        headAtOrigin=true,
        R=R_0) if planarWorld.enableAnimation and animation;
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector arrowTorque(
        coordinates=t_in_m,
        color=color,
        specularCoefficient=specularCoefficient,
        r=rvisobj,
        quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque,
        headAtOrigin=true,
        R=planarWorld.R) if planarWorld.enableAnimation and animation;

    equation
      if resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b then
        phi = frame_b.phi;
      elseif resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world then
        phi = 0;
      end if;

      R = {{cos(phi), -sin(phi)}, {sin(phi),cos(phi)}};
      {frame_b.fx,frame_b.fy} + R*{force[1], force[2]} = {0, 0};
      frame_b.t + force[3]= 0;

      annotation (
        obsolete = "Obsolete model - use PlanarMechanics.Sources.WorldForce instead",
        Icon(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
            Line(
              points={{0,0},{0,-100}},
              color={95,95,95},
              pattern=LinePattern.Dot,
              visible=resolveInFrame==Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve),
            Polygon(
              points={{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},
                  {-100,10}},
              lineColor={0,127,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,80},{150,40}},
              textString="%name",
              textColor={0,0,255})}),
        Documentation(
          info="<html>
<p>
Obsolete model of the <strong>3</strong> signals of the <strong>force</strong> connector which
contains force and torque.
This model is only provided for backward compatibility &ndash; use
<a href=\"modelica://PlanarMechanics.Sources.WorldForce\">PlanarMechanics.Sources.WorldForce</a>
instead.
</p>
<p>
Note: the input connectors were changed. Instead of <code>force[3]</code>,
there are <code>force[2]</code> and <code>torque</code> in 
<a href=\"modelica://PlanarMechanics.Sources.WorldForce\">PlanarMechanics.Sources.WorldForce</a>
now. Consequently, the obsolete usage like
</p>
<blockquote><pre>
  <font style=\"color:red;font-family:courier;\">ObsoletePlanarMechanics2.Sources.WorldForce</font> worldForce1;
  <font style=\"color:red;font-family:courier;\">ObsoletePlanarMechanics2.Sources.WorldForce</font> worldForce2;
  Whatever.Signal.Source1 signal[3];
  Whatever.Signal.Source2 signal_yVec;
  ...
<strong>equation</strong>
  <strong>connect</strong>(signal.y, worldForce1.force);
  <strong>connect</strong>(signal_yVec.y, worldForce2.force);
  ...
</pre></blockquote>
<p>
shall be changed to
</p>
<blockquote><pre>
  
  <font style=\"color:#cc00ff;font-family:courier;\">PlanarMechanics.Sources.WorldForce</font> worldForce1;
  <font style=\"color:#cc00ff;font-family:courier;\">PlanarMechanics.Sources.WorldForce</font> worldForce2;
  Whatever.Signal.Source1 signal[3];
  Whatever.Signal.Source2 signal_yVec;
  ...
<strong>equation</strong>
  <strong>connect</strong>(signal<font style=\"color:#cc00ff;font-family:courier;\">[1:2]</font>.y, worldForce1.force);
  <strong>connect</strong>(signal<font style=\"color:#cc00ff;font-family:courier;\">[3]</font>.y, worldForce1.<font style=\"color:#cc00ff;font-family:courier;\">torque</font>);
  <strong>connect</strong>(signal_yVec.y<font style=\"color:#cc00ff;font-family:courier;\">[1:2]</font>, worldForce2.force);
  <strong>connect</strong>(signal_yVec.y<font style=\"color:#cc00ff;font-family:courier;\">[3]</font>, worldForce2.<font style=\"color:#cc00ff;font-family:courier;\">torque</font>);
  ...
</pre></blockquote>
<p>
Optionally, especially for graphical modeling, a&nbsp;<a href=\"modelica://Modelica.Blocks.Routing.DeMultiplex3\">DeMultiplexer</a>
can be used instead to split source signals.
</p>

</html>
",        revisions="<html>
<p>
<img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\" alt=\"DLR logo\">
<strong>Developed 2010 at the DLR Institute of System Dynamics and Control</strong>
</p>
</html>"));
    end WorldForce;
  end Sources;

  package Visualizers "Visualization components of the library"
    extends Modelica.Icons.Package;

    package Advanced "Visualizers that require advanced knowledge in order to use them properly"
      extends Modelica.Icons.Package;

      model DoubleArrow
        "Visualizing a double arrow with variable size; all data have to be set as modifiers (see info layer)"
        extends Modelica.Icons.ObsoleteModel;

        import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
        import Modelica.Units.Conversions.to_unit1;

        input Modelica.Mechanics.MultiBody.Frames.Orientation R=Modelica.Mechanics.MultiBody.Frames.nullRotation()
          "Orientation object to rotate the planarWorld frame into the arrow frame" annotation(Dialog);
        input Modelica.Units.SI.Position r[3]={0,0,0}
          "Position vector from origin of planarWorld frame to origin of arrow frame, resolved in planarWorld frame"
          annotation(Dialog);
        input Modelica.Units.SI.Position r_tail[3]={0,0,0}
          "Position vector from origin of arrow frame to double arrow tail, resolved in arrow frame"
          annotation(Dialog);
        input Modelica.Units.SI.Position r_head[3]={0,0,0}
          "Position vector from double arrow tail to the head of the double arrow, resolved in arrow frame"
          annotation(Dialog);
        input Modelica.Units.SI.Diameter diameter=planarWorld.defaultArrowDiameter
          "Diameter of arrow line" annotation(Dialog);
        input Modelica.Mechanics.MultiBody.Types.Color color=PlanarMechanics.Types.Defaults.ArrowColor
          "Color of double arrow" annotation(HideResult=true, Dialog(colorSelector=true));
        input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient specularCoefficient = planarWorld.defaultSpecularCoefficient
          "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"
          annotation(HideResult=true, Dialog);

      protected
        outer PlanarMechanics.PlanarWorld planarWorld;
        Modelica.Units.SI.Length length=Modelica.Math.Vectors.length(r_head) "Length of arrow";
        Real e_x[3](each final unit="1", start={1,0,0}) = noEvent(if length < 1.e-10 then {1,0,0} else r_head/length);
        Real rxvisobj[3](each final unit="1") = transpose(R.T)*e_x
          "X-axis unit vector of shape, resolved in planarWorld frame"
            annotation (HideResult=true);
        Modelica.Units.SI.Position rvisobj[3] = r + T.resolve1(R.T, r_tail)
          "Position vector from planarWorld frame to shape frame, resolved in planarWorld frame"
            annotation (HideResult=true);

        Modelica.Units.SI.Length headLength=noEvent(max(0, length - arrowLength))
          annotation(HideResult=true);
        Modelica.Units.SI.Length headWidth=noEvent(max(0, diameter*PlanarMechanics.Types.Defaults.ArrowHeadWidthFraction))
          annotation(HideResult=true);
        Modelica.Units.SI.Length arrowLength = noEvent(max(0, length - 1.5*diameter*PlanarMechanics.Types.Defaults.ArrowHeadLengthFraction))
          annotation(HideResult=true);

        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape arrowLine(
          length=arrowLength,
          width=diameter,
          height=diameter,
          lengthDirection=to_unit1(r_head),
          widthDirection={0,1,0},
          shapeType="cylinder",
          color=color,
          specularCoefficient=specularCoefficient,
          r_shape=r_tail,
          r=r,
          R=R) if planarWorld.enableAnimation;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape arrowHead1(
          length=2/3*headLength,
          width=headWidth,
          height=headWidth,
          lengthDirection=to_unit1(r_head),
          widthDirection={0,1,0},
          shapeType="cone",
          color=color,
          specularCoefficient=specularCoefficient,
          r=rvisobj + rxvisobj*arrowLength,
          R=R) if planarWorld.enableAnimation;
        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape arrowHead2(
          length=2/3*headLength,
          width=headWidth,
          height=headWidth,
          lengthDirection=to_unit1(r_head),
          widthDirection={0,1,0},
          shapeType="cone",
          color=color,
          specularCoefficient=specularCoefficient,
          r=rvisobj + rxvisobj*(arrowLength + headLength/3),
          R=R) if planarWorld.enableAnimation;

        annotation (
          obsolete = "Obsolete model - use Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow instead",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-100,30},{0,-30}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{40,60},{100,0},{40,-60},{40,60}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{0,60},{60,0},{0,-60},{0,60}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-150,100},{150,60}},
                textString="%name",
                textColor={0,0,255})}),
          Documentation(info="<html>
<p>
Obsolete model that was previously used to visualize a&nbsp;double arrow
that is dynamically scaled at the defined location. This model is only provided for
backward compatibility &ndash; use
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.DoubleArrow</a>
instead.
Optionally,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector</a>
can be used for visualization of a&nbsp;3-dimensional torque quantity.
</p>
</html>"));
      end DoubleArrow;
    end Advanced;
  end Visualizers;

  annotation (
    preferredView="info",
    version="2.0.0",
    versionDate="2025-11-27",
    dateModified="2025-11-27 12:00:00Z",
    uses(
      Modelica(version="4.1.0"),
      PlanarMechanics(version="2.0.0")),
    Documentation(
      info="<html>
<p>
This package contains models and blocks from the PlanarMechanics Library
version 1.6.0 that are no longer available in the version 2.0.0.
The conversion script for version 2.0.0 changes references in existing
user models automatically to the models and blocks of package
ObsoletePlanarMechanics2. The user should <strong>manually</strong> replace all
references to ObsoletePlanarMechanics2 in his/her models to the models
that are recommended in the documentation of the respective model.
</p>

<p>
In most cases, this means that a&nbsp;model with the name
\"ObsoletePlanarMechanics2.XY\" should be renamed to \"PlanarMechanics.YZ\"
(version 2.0.0) and manually adaptated afterwards.
This usually requires some changes at the place where
the class is used (besides the renaming of the underlying class).
</p>

<p>
The models in ObsoletePlanarMechanics2 either not comply to the
Modelica Language version 3.4 and higher, or the model was changed significantly
to get a&nbsp;better design.
In all cases, an automatic conversion to the new implementation
was not feasible.
</p>

<p>
In order to easily detect obsolete models and blocks, all of them are particularly
marked in the icon layer with a red box.
</p>


<h4>Licensed by DLR under the 3-Clause BSD License</h4>
<p>
Copyright &copy; 2024, Deutsches Zentrum f&uuml;r Luft- und Raumfahrt (DLR)
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely
at <u>your own risk</u>; it can be redistributed and/or modified under
the terms of the 3-Clause BSD license. For license conditions (including
the disclaimer of warranty) visit
<a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"));
end ObsoletePlanarMechanics2;

within ;
package ObsoletePlanarMechanics2 "Library that contains components from PlanarMechanics Library 1.6.0 that have been removed from version 2.0.0"
  extends Modelica.Icons.Package;

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
    versionDate="2024-01-08",
    dateModified = "2024-01-08 12:00:00Z",
    uses(
      Modelica(version="4.0.0"),
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

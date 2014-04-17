within PlanarMechanics.Examples;
model FreeBody "AcceleratingBody"
  extends Modelica.Icons.Example;

  inner PlanarWorld planarWorld
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Parts.Body body(m=1, I=0.1,
    animate=true,
    a(fixed=false),
    r(fixed=true),
    v(fixed=true),
    phi(fixed=true),
    w(fixed=true))
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  annotation (
    experiment(StopTime=3),
    __Dymola_experimentSetupOutput,
    Documentation(revisions=
          "<html><p><img src=\"modelica://PlanarMechanics/Resources/Images/dlr_logo.png\"/> <b>Developed 2010-2014 at the DLR Institute of System Dynamics and Control</b> </p></html>",
                                                                                                    info="<html>
<p><h4><font color=\"#008000\">A simple free falling body.</font></h4></p>
<p><br/>The gravity is defined in the planarWorld component</p>
<p><br/><img src=\"modelica://PlanarMechanics/Resources/Images/FreeBody_1.png\"/></p>
<p><br/>The&nbsp;DAE&nbsp;has&nbsp;73&nbsp;scalar&nbsp;unknowns&nbsp;and&nbsp;73&nbsp;scalar&nbsp;equations.</p>
</html>",
      revisions="<html>
<p>(c) Copyright by Dirk Zimmer</p>
<p>The library was creates and is owned by Dr. Dirk Zimmer. </p>
<p>dirk.zimmer@dlr.de</p>
</html>"),
    Diagram(graphics));
end FreeBody;

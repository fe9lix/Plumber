Plumber
==========

Plumber is a tiny Objective-C library for creating curved connection lines between nodes (for example, for flowcharts and the like). I have created it since a quick Google search did not reveal anything simple for iOS. The curve calculation algorithm is a direct port of the function used in the [Graffle Example](http://raphaeljs.com/graffle.html) of the vector drawing library [Raphaël](http://raphaeljs.com/).

### Installation
Just drag the folder `Plumber/Plumber` with its two classes `Plumber` and `PlumberConnection` into your Xcode project.

### How to use it

The API couldn't be simpler: There's just one method `connect` that takes two CGRects (usually from a UIView or CALayer) and returns a new `PlumberConnection`, which is an immutable value object holding the original CGRects and the calculated UIBezierPath.

```objective-c
Plumber *plumber = [Plumber new];
PlumberConnection *connection = [plumber connectFrom:layerA.frame to:layerB.frame];
UIBezierPath *path = connection.path;
// draw the path...

```

See the example app (`Plumber/Example`) on how you could implement draggable shapes with their connection lines updated.

###License
[The MIT License](http://opensource.org/licenses/MIT)
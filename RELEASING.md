## Publish the official release

1. Have all release-blocking clients given the go-ahead? **Do not create the official release until
   all release-blocking clients are ready**. Otherwise you might publish a release that isn't
   actually stable.
1. Visit our
   [GitHub list of releases](releases), click on
   "Draft a new release".
1. Tag the release "vX.Y.Z".
1. Select the stable branch.
1. Title the release "Release X.Y.Z".
1. In the body of the release notes, paste the text from [CHANGELOG.md](CHANGELOG.md) for this release.
1. Publish the release.

## Publish to Cocoapods

    pod trunk push --use-libraries

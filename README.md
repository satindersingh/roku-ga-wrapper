# roku-ga-wrapper
A Bright script based Roku interface to integrate Google Analytics.

## Introduction

Roku-ga-wrapper is interface which can be integrated into you roku application to add google analytics.

This is able to do following things:

1. Screen Tracking
2. Event Tracking

## Requirements

Roku SDK

Roku device

## Usage

#### Basic Integration

- Copy the analytics folder under the component folder of your current roku project.

- Call below lines to track screen transitions in your project. 

  ```Bright script
  Analytics = m.top.createChild("Analytics")
  Analytics.id = "Analytics"
  Analytics.setField("screen", "screen name")
  Analytics.traceScreen = true
  Analytics.control = "RUN"
  ```


- Call below lines to track event in you project. 

      Analytics = m.top.createChild("Analytics")
      Analytics.id = "Analytics"
      Analytics.setField("category", "event category")
      Analytics.setField("action", "event action")
      Analytics.trackEvent = true
      Analytics.control = "RUN"



Don't add analytics folder (analytics.xml, analytics.brs & config.brs files) under source folder.

Please refer the demo application for more details.

## License

This project is licensed under the terms of the MIT license.


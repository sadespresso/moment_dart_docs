---
sidebar_position: 6
id: relativeFinders
---

# Relative finders

Starting with version `2.0.0`, you can use relative helpers.

## List of methods

All of the methods preserve the timezone. Meaning, if a method was called on
`DateTime` object in UTC timezone, it will return an object in UTC timezone.

* `startOfNextYear()`
* `startOfLastYear()`
* `endOfNextYear()`
* `endOfLastYear()`
* `startOfNextMonth()`
* `startOfLastMonth()`
* `endOfNextMonth()`
* `endOfLastMonth()`
* `startOfNextLocalWeek([int? weekStart])`
* `startOfLastLocalWeek([int? weekStart])`
* `endOfNextLocalWeek([int? weekStart])`
* `endOfLastLocalWeek([int? weekStart])`
* `startOfNextIsoWeek()`
* `startOfLastIsoWeek()`
* `endOfNextIsoWeek()`
* `endOfLastIsoWeek()`
* `startOfNextDay()`
* `startOfLastDay()`
* `endOfNextDay()`
* `endOfLastDay()`
* `startOfNextHour()`
* `startOfLastHour()`
* `endOfNextHour()`
* `endOfLastHour()`
* `startOfNextMinute()`
* `startOfLastMinute()`
* `endOfNextMinute()`
* `endOfLastMinute()`

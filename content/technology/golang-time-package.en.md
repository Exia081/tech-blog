---
title: "Go Time Package Usage Examples"
date: 2024-01-15T10:00:00+08:00
categories: ["Technology"]
tags: ["Go", "Programming", "Time Handling"]
author: "Author"
description: "Detailed introduction to common features and best practices of Go's time package"
---

# Go Time Package Usage Examples

Go's `time` package is the core package for handling time and dates, providing rich functionality for time-related operations.

## Basic Time Operations

### Getting Current Time

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    // Get current time
    now := time.Now()
    fmt.Println("Current time:", now)
    
    // Format time output
    fmt.Println("Formatted time:", now.Format("2006-01-02 15:04:05"))
}
```

### Time Parsing

```go
// Parse time string
timeStr := "2024-01-15 10:30:00"
t, err := time.Parse("2006-01-02 15:04:05", timeStr)
if err != nil {
    fmt.Println("Time parsing error:", err)
    return
}
fmt.Println("Parsed time:", t)
```

## Time Calculations

### Adding/Subtracting Time

```go
now := time.Now()

// Add time
futureTime := now.Add(24 * time.Hour)  // 24 hours later
fmt.Println("24 hours later:", futureTime)

// Subtract time
pastTime := now.Add(-2 * time.Hour)   // 2 hours ago
fmt.Println("2 hours ago:", pastTime)
```

### Duration Calculation

```go
start := time.Now()
time.Sleep(2 * time.Second)
end := time.Now()

duration := end.Sub(start)
fmt.Println("Execution time:", duration)
```

## Timezone Handling

```go
// Load timezone
beijingTZ, _ := time.LoadLocation("Asia/Shanghai")
utcTZ, _ := time.LoadLocation("UTC")

now := time.Now()
fmt.Println("Local time:", now)
fmt.Println("Beijing time:", now.In(beijingTZ))
fmt.Println("UTC time:", now.In(utcTZ))
```

## Best Practices

1. **Always check errors**: Time parsing can fail, handle errors properly
2. **Use UTC for storage**: Store UTC time in database, convert to local time for display
3. **Avoid timezone confusion**: Explicitly specify timezone, avoid implicit conversions
4. **Performance considerations**: Consider performance impact of frequent time operations

## Summary

Go's time package is powerful and easy to use. Mastering these basic operations helps us better handle time-related business logic. In actual development, pay special attention to timezone handling and error handling.
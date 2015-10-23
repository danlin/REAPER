////////////////////////////////////////////////////////////////////////////////
// 
// Copyright (c) 2014-2015 Ultraschall (http://ultraschall.fm)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
// 
////////////////////////////////////////////////////////////////////////////////

#include "EntryPoints.h"

namespace ultraschall { namespace reaper {

HWND (*EntryPoints::pGetMainHwnd_)() = 0;
void *(*EntryPoints::pEnumProjects_)(int idx, char *projfn, int projfnlen) = 0;

void (*EntryPoints::pGetProjectPath_)(char* buffer, int bufferSize) = 0;
void *(*EntryPoints::pEnumProjects2_)(int offset, char *buffer, int bufferSize) = 0;

void (*EntryPoints::p_format_timestr_pos_)(double timestamp, char *buffer, int bufferSize, int modeOverride) = 0;
double (*EntryPoints::p_parse_timestr_)(const char* buffer) = 0;

int (*EntryPoints::pEnumProjectMarkers_)(int offset, bool *pIsRegion, double *pTimestamp, double *pEndOfRegion, char **ppName, int *pMarkerRegionIndex) = 0;
int (*EntryPoints::pAddProjectMarker2_)(void* projectHandle, bool isRegion, double timestamp, double endOfRegion, const char* pName, int markerRegionIndex, int color) = 0;
bool (*EntryPoints::pDeleteProjectMarker)(ReaProject* proj, int markrgnindexnumber, bool isrgn) = 0;
bool (*EntryPoints::pDeleteProjectMarkerByIndex)(ReaProject* proj, int markrgnidx) = 0;

int (*EntryPoints::pGetNumTracks_)() = 0;
const char* (*EntryPoints::pGetTrackInfo_)(INT_PTR track, int *flags) = 0;
   
void* (*EntryPoints::pGetTrack_)(void* projectHandle, int trackIndex) = 0;
void* (*EntryPoints::pGetSetMediaTrackInfo_)(void* track, const char* parameter, char* newValue) = 0;

   
}}
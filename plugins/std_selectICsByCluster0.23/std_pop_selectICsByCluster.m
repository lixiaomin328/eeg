function varargout = std_pop_selectICsByCluster(varargin)
% STD_POP_SELECTICSBYCLUSTER MATLAB code for std_pop_selectICsByCluster.fig
%      STD_POP_SELECTICSBYCLUSTER, by itself, creates a new STD_POP_SELECTICSBYCLUSTER or raises the existing
%      singleton*.
%
%      H = STD_POP_SELECTICSBYCLUSTER returns the handle to a new STD_POP_SELECTICSBYCLUSTER or the handle to
%      the existing singleton*.
%
%      STD_POP_SELECTICSBYCLUSTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STD_POP_SELECTICSBYCLUSTER.M with the given input arguments.
%
%      STD_POP_SELECTICSBYCLUSTER('Property','Value',...) creates a new STD_POP_SELECTICSBYCLUSTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before std_pop_selectICsByCluster_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to std_pop_selectICsByCluster_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help std_pop_selectICsByCluster

% Last Modified by GUIDE v2.5 11-Oct-2017 12:31:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @std_pop_selectICsByCluster_OpeningFcn, ...
                   'gui_OutputFcn',  @std_pop_selectICsByCluster_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before std_pop_selectICsByCluster is made visible.
function std_pop_selectICsByCluster_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to std_pop_selectICsByCluster (see VARARGIN)

% Choose default command line output for std_pop_selectICsByCluster
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes std_pop_selectICsByCluster wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = std_pop_selectICsByCluster_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function includingClusterIdxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to includingClusterIdxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of includingClusterIdxEdit as text
%        str2double(get(hObject,'String')) returns contents of includingClusterIdxEdit as a double


% --- Executes during object creation, after setting all properties.
function includingClusterIdxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to includingClusterIdxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in savePathPushbutton.
function savePathPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to savePathPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% launch GUI to obtain directory
targetDirectory = uigetdir;
if any(targetDirectory)
    set(handles.savePathEdit, 'String', targetDirectory);
end


% --- Executes on button press in skipToStoreDataCheckbox.
function skipToStoreDataCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to skipToStoreDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of skipToStoreDataCheckbox


function savePathEdit_Callback(hObject, eventdata, handles)
% hObject    handle to savePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of savePathEdit as text
%        str2double(get(hObject,'String')) returns contents of savePathEdit as a double


% --- Executes during object creation, after setting all properties.
function savePathEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savePathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function excludingClusterIdxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to excludingClusterIdxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of excludingClusterIdxEdit as text
%        str2double(get(hObject,'String')) returns contents of excludingClusterIdxEdit as a double


% --- Executes during object creation, after setting all properties.
function excludingClusterIdxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to excludingClusterIdxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in helpPushbutton.
function helpPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to helpPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pophelp('std_selectICsByCluster.m')


% --- Executes on button press in excludingClusterCheckbox.
function excludingClusterCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to excludingClusterCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of excludingClusterCheckbox


% --- Executes on button press in startPushbutton.
function startPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ALLEEG   = evalin('base', 'ALLEEG');
EEG      = evalin('base', 'EEG');
STUDY    = evalin('base', 'STUDY');
if get(handles.excludingClusterCheckbox, 'Value');
    excludingClusterIdx = str2num(get(handles.includingClusterIdxEdit, 'String'));
    if strcmp(STUDY.cluster(2).name, 'outlier 2')
        includingClusterIdx = setdiff(3:length(STUDY.cluster), excludingClusterIdx);
    else
        includingClusterIdx = setdiff(2:length(STUDY.cluster), excludingClusterIdx);
    end
else
    includingClusterIdx = str2num(get(handles.includingClusterIdxEdit, 'String'));
end
excludingClusterFromPvafIdx   = str2num(get(handles.excludingClusterIdxEdit, 'String'));
savePath                      = get(handles.savePathEdit, 'String');

std_selectICsByCluster(STUDY, ALLEEG, EEG, includingClusterIdx, excludingClusterFromPvafIdx, savePath); % It will 'assign in' so no outputs.

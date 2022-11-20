function varargout = phaseperception(varargin)
% PHASEPERCEPTION M-file for phaseperception.fig
%      PHASEPERCEPTION, by itself, creates a new PHASEPERCEPTION or raises the existing
%      singleton*.
%
%      H = PHASEPERCEPTION returns the handle to a new PHASEPERCEPTION or the handle to
%      the existing singleton*.
%
%      PHASEPERCEPTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHASEPERCEPTION.M with the given input arguments.
%
%      PHASEPERCEPTION('Property','Value',...) creates a new PHASEPERCEPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before phasenwahrnehmung_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to phaseperception_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help phaseperception

% Last Modified by GUIDE v2.5 16-Oct-2018 12:02:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @phaseperception_OpeningFcn, ...
                   'gui_OutputFcn',  @phaseperception_OutputFcn, ...
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


% --- Executes just before phaseperception is made visible.
function phaseperception_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to phaseperception (see VARARGIN)

% Choose default command line output for phaseperception
handles.output = hObject;
% initialize Data
fS = 8000;    % sampling frequency
f1 = 400;     % freq. of 1st sin
f2 = 800;     % freq. of 1st sin
a = .1;        % amplidute of 1st sin
secs = 1;     % duration of signal
handles.fS = fS;
handles.f1 = f1;
handles.f2 = f2;
handles.a = a;
handles.secs = secs;
handles.phi = 0;
[s,t] = cos2sigphi(handles.secs, handles.a, handles.f1, handles.f2, handles.fS, handles.phi);
handles.s = s;
plot(t(1:100),s(1:100));
axis([0 100 -2*handles.a 2*handles.a]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes phaseperception wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = phaseperception_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
phi = get(hObject,'Value');
handles.phi = phi;
[s,t] = cos2sigphi(handles.secs, handles.a, handles.f1, handles.f2, handles.fS, handles.phi);
handles.s = s;
guidata(hObject, handles);
plot(t(1:100),s(1:100));
axis([0 100 -2*handles.a 2*handles.a]);
xlabel('Sample number');
ylabel('Amplitude');
title('Phase Perception');

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
f1 = str2double(get(hObject,'String'));
handles.f1 = f1;
[s,t] = cos2sigphi(handles.secs, handles.a, handles.f1, handles.f2, handles.fS, handles.phi);
handles.s = s;
plot(t(1:100),s(1:100));
axis([0 100 -2*handles.a 2*handles.a]);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press over edit1 with no controls selected.
function edit1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
f2 = str2double(get(hObject,'String'));
handles.f2 = f2;
[s,t] = cos2sigphi(handles.secs, handles.a, handles.f1, handles.f2, handles.fS, handles.phi);
handles.s = s;
plot(t(1:100),s(1:100));
axis([0 100 -2*handles.a 2*handles.a]);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sound(handles.s,handles.fS);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press over edit2 with no controls selected.
function edit2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



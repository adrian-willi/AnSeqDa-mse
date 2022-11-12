function varargout = aliasing(varargin)
% ALIASING M-file for aliasing.fig
%      ALIASING, by itself, creates a new ALIASING or raises the existing
%      singleton*.
%
%      H = ALIASING returns the handle to a new ALIASING or the handle to
%      the existing singleton*.
%
%      ALIASING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALIASING.M with the given input arguments.
%
%      ALIASING('Property','Value',...) creates a new ALIASING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aliasing_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aliasing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aliasing

% Last Modified by GUIDE v2.5 10-May-2006 23:59:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aliasing_OpeningFcn, ...
                   'gui_OutputFcn',  @aliasing_OutputFcn, ...
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


% --- Executes just before aliasing is made visible.
function aliasing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aliasing (see VARARGIN)

% Choose default command line output for aliasing
handles.output = hObject;


% Update handles structure
handles.fS = 4000;   % sampling frequency
handles.a = 0.5;     % signal amplitude
handles.secs = 1     % signal duration
handles.f = 1000;    % initial signal
guidata(hObject, handles);
[s t] = cossig1(handles.secs, handles.a, handles.f, handles.fS);
[s0 t0] = cossig1(handles.secs, handles.a, handles.f, 40000);  %analog signal
t = t/handles.fS;
t0 = t0/40000;
handles.s = s;
handles.t = t;
stem(t(1:20),s(1:20),'-o');
hold on;
plot(t0(1:200),s0(1:200),'r');
hold off;
legend('sampled signal', 'analog signal');
legend show;
title('Aliasing (Sampling Frequency 4000 Hz)');
xlabel('time [s]');
sound(s,handles.fS);
guidata(hObject, handles);

% UIWAIT makes aliasing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aliasing_OutputFcn(hObject, eventdata, handles) 
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
f = get(hObject,'Value');
set(handles.ed1,'String',f);   % synchronize Textfield
[s t] = cossig1(handles.secs, handles.a, f, handles.fS);  % sampled signal
[s0 t0] = cossig1(handles.secs, handles.a, f, 40000);  %analog signal
t = t/handles.fS;
t0 = t0/40000;
handles.s = s;
handles.t = t;
stem(t(1:20),s(1:20),'-o');
hold on;
plot(t0(1:200),s0(1:200),'r');
hold off;
legend('sampled signal', 'analog signal');
legend show;
title('Aliasing (Sampling Frequency 4000 Hz)');
xlabel('time [s]');
sound(s,handles.fS);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',1000);
handles.sl1 = hObject;
guidata(hObject, handles);




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
f = str2double(get(hObject,'String'));   % synchronize slider
set(handles.sl1,'Value',f);
[s t] = cossig1(handles.secs, handles.a, f, handles.fS);  % sampled signal
[s0 t0] = cossig1(handles.secs, handles.a, f, 40000);  %analog signal
t = t/handles.fS;
t0 = t0/40000;
handles.s = s;
handles.t = t;
stem(t(1:20),s(1:20),'-o');
hold on;
plot(t0(1:200),s0(1:200),'r');
hold off;
legend('sampled signal', 'analog signal');
legend show;
title('Aliasing (Sampling Frequency 4000 Hz)');
xlabel('time [s]');
sound(s,handles.fS);
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
handles.ed1 = hObject;
set(handles.ed1,'String',1000);
guidata(hObject, handles);


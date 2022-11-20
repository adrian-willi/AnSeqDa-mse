function varargout = maskingeffect(varargin)
% MASKINGEFFECT M-file for maskingeffect.fig
%      MASKINGEFFECT, by itself, creates a new MASKINGEFFECT or raises the existing
%      singleton*.
%
%      H = MASKINGEFFECT returns the handle to a new MASKINGEFFECT or the handle to
%      the existing singleton*.
%
%      MASKINGEFFECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASKINGEFFECT.M with the given input arguments.
%
%      MASKINGEFFECT('Property','Value',...) creates a new MASKINGEFFECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before verdeckungseffekt_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maskingeffect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maskingeffect

% Last Modified by GUIDE v2.5 16-Oct-2018 16:49:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maskingeffect_OpeningFcn, ...
                   'gui_OutputFcn',  @maskingeffect_OutputFcn, ...
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


% --- Executes just before maskingeffect is made visible.
function maskingeffect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maskingeffect (see VARARGIN)

% Choose default command line output for maskingeffect
handles.output = hObject;

% Update handles structure
handles.fS = 8000;
handles.secs = 1;
handles.a = 0.01;
handles.bf = 1000;  % center freq of bandpass noise
handles.df = 80;    % bandwidth of noise
handles.f = 500;
bn = bandpassnoise1(handles.secs, handles.bf, handles.df, 1, handles.fS); 
handles.bn = bn';
guidata(hObject, handles);
handles.s = cossig1(handles.secs, handles.a, handles.f, handles.fS);  % 500 Hz Signal 
handles.sbn = handles.s + handles.bn;
guidata(hObject, handles);
plotandsound(handles);
% [x,y,lim] = ft(handles.sbn,1/handles.fS);
% plot(x,20*log10(y(lim)));
% axis([0 4 -30 60]);
% title('Masking Effect');
% xlabel('Frequency in kHz');
% ylabel('Amplitude in dB');
% sound(handles.sbn);

% UIWAIT makes maskingeffect wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = maskingeffect_OutputFcn(hObject, eventdata, handles) 
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
handles.s = cossig1(handles.secs, handles.a, f, handles.fS);  % 1000 Hz Signal 
handles.f = f;
handles.sbn = handles.s + handles.bn;
guidata(hObject, handles);
plotandsound(handles);
% [x,y,lim] = ft(handles.sbn,1/handles.fS);
% plot(x,20*log10(y(lim)));
% axis([0 4 -30 60]);
% title('Masking Effect');
% xlabel('Frequency in kHz');
% ylabel('Amplitude in dB');
% sound(handles.sbn);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',500);
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
handles.s = cossig1(handles.secs, handles.a, f, handles.fS);  % 1000 Hz Signal 
handles.f = f;
handles.sbn = handles.s + handles.bn;
guidata(hObject, handles);
plotandsound(handles);

function plotandsound(handles)
%
%  plots the spectrum and sounds handles.sbn
%
[x,y,lim] = ft(handles.sbn,1/handles.fS);
plot(x,20*log10(y(lim)));
axis([0 4 -30 60]);
title('Masking Effect');
xlabel('Frequency in kHz');
ylabel('Amplitude in dB');
sound(handles.sbn);

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
set(handles.ed1,'String',500);
guidata(hObject, handles);





function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
handles.a = str2double(get(hObject,'String'));   % synchronize slider
guidata(hObject, handles);
handles.s = cossig1(handles.secs, handles.a, handles.f, handles.fS);  % 1000 Hz Signal 
handles.sbn = handles.s + handles.bn;
plotandsound(handles);


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
set(hObject,'String',0.01);



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
bf = str2double(get(hObject,'String'));   % synchronize slider
bn = bandpassnoise1(handles.secs, bf, handles.df, 1, handles.fS); 
handles.bn = bn';
guidata(hObject, handles);
  % 1000 Hz Signal 
handles.sbn = handles.s + handles.bn;
plotandsound(handles);

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',1000);




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

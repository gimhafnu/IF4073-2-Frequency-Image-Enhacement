%% 
function varargout = GUI2(varargin)
% GUI2 MATLAB code for GUI2.fig
%      GUI2, by itself, creates a new GUI2 or raises the existing
%      singleton*.
%
%      H = GUI2 returns the handle to a new GUI2 or the handle to
%      the existing singleton*.
%
%      GUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI2.M with the given input arguments.
%
%      GUI2('Property','Value',...) creates a new GUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI2

% Last Modified by GUIDE v2.5 01-Mar-2022 17:42:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI2_OutputFcn, ...
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


% --- Executes just before GUI2 is made visible.
function GUI2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI2 (see VARARGIN)

% Choose default command line output for GUI2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in uploadimage.
function uploadimage_Callback(hObject, eventdata, handles)
% hObject    handle to uploadimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = 'F:/';
if ~exist(startingFolder, 'dir')
  % If that folder doesn't exist, just start in the current folder.
  startingFolder = pwd;
end
% Get the name of the file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.*');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
if baseFileName == 0
  % User clicked the Cancel button.
  return;
end
fullFileName = fullfile(folder, baseFileName);
a = imread(fullFileName);
axes(handles.axes2);
imshow(a);
setappdata(0, 'image1', a);

% --- Executes on button press in spectrum1.
function spectrum1_Callback(hObject, eventdata, handles)
% hObject    handle to spectrum1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
[~,~,z] = size(image);
axes(handles.axes3);
if z == 1
    fourier_spectrum(image);
end

% --- Executes on button press in spectrum2.
function spectrum2_Callback(hObject, eventdata, handles)
% hObject    handle to spectrum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image2');
[~,~,z] = size(image);
axes(handles.axes5);
if z == 1
    fourier_spectrum(image);
end

% --- Executes on button press in brightness.
function brightness_Callback(hObject, eventdata, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
F = fft2(double(image));
G = F * 3;
g=uint8(real(ifft2(G)));
axes(handles.axes4);
imshow(g);
setappdata(0, 'image2', g);

% --- Executes on button press in noise.
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
F = fft2(double(image));

% --- Executes on button press in butterworthhpf.
function butterworthhpf_Callback(hObject, eventdata, handles)
% hObject    handle to butterworthhpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
fimage = highPassFilterWrapper(image, "Butterwoth");
axes(handles.axes4);
imshow(fimage);
setappdata(0, 'image2', fimage);

% --- Executes on button press in gaussianhpf.
function gaussianhpf_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianhpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
fimage = highPassFilterWrapper(image, "Gaussian");
axes(handles.axes4);
imshow(fimage);
setappdata(0, 'image2', fimage);

% --- Executes on button press in idealhpf.
function idealhpf_Callback(hObject, eventdata, handles)
% hObject    handle to idealhpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
fimage = highPassFilterWrapper(image, "Ideal");
axes(handles.axes4);
imshow(fimage);
setappdata(0, 'image2', fimage);

% --- Executes on button press in ideallpf.
function ideallpf_Callback(hObject, eventdata, handles)
% hObject    handle to ideallpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
fimage = lowpass_frequency_wrapper(image, "Ideal");
axes(handles.axes4);
imshow(fimage);
setappdata(0, 'image2', fimage);

% --- Executes on button press in gaussianlpf.
function gaussianlpf_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianlpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
fimage = lowpass_frequency_wrapper(image, "Gaussian");
axes(handles.axes4);
imshow(fimage);
setappdata(0, 'image2', fimage);

% --- Executes on button press in butterworthlpf.
function butterworthlpf_Callback(hObject, eventdata, handles)
% hObject    handle to butterworthlpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
fimage = lowpass_frequency_wrapper(image, "Butterwoth");
axes(handles.axes4);
imshow(fimage);
setappdata(0, 'image2', fimage);


% --- Executes on button press in g1.
function g1_Callback(hObject, eventdata, handles)
% hObject    handle to g1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
[~,~,z] = size(image);
axes(handles.axes3);
if z > 1
    fourier_spectrum(image(:,:,2));
end



% --- Executes on button press in b1.
function b1_Callback(hObject, eventdata, handles)
% hObject    handle to b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
[~,~,z] = size(image);
axes(handles.axes3);
if z > 1
    fourier_spectrum(image(:,:,3));
end

% --- Executes on button press in r1.
function r1_Callback(hObject, eventdata, handles)
% hObject    handle to r1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image1');
[~,~,z] = size(image);
axes(handles.axes3);
if z > 1
    fourier_spectrum(image(:,:,1));
end

% --- Executes on button press in g2.
function g2_Callback(hObject, eventdata, handles)
% hObject    handle to g2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image2');
[~,~,z] = size(image);
axes(handles.axes5);
if z > 1
    fourier_spectrum(image(:,:,2));
end

% --- Executes on button press in b2.
function b2_Callback(hObject, eventdata, handles)
% hObject    handle to b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image2');
[~,~,z] = size(image);
axes(handles.axes5);
if z > 1
    fourier_spectrum(image(:,:,3));
end

% --- Executes on button press in r2.
function r2_Callback(hObject, eventdata, handles)
% hObject    handle to r2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getappdata(0, 'image2');
[~,~,z] = size(image);
axes(handles.axes5);
if z > 1
    fourier_spectrum(image(:,:,1));
end
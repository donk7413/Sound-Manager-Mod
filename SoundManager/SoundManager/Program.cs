using Microsoft.VisualStudio.Threading;
using NAudio.Wave;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Media;
using System.Threading;
using System.Threading.Tasks;

namespace SoundManager
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Starting Listen for a sound!");
            Console.WriteLine(Directory.GetCurrentDirectory());
            DirectoryInfo directoryInfo = Directory.GetParent(Directory.GetCurrentDirectory());

            System.Console.WriteLine(directoryInfo.FullName);
            bool Activated = true;
            bool Debug = File.Exists(@"..\debug.txt");
            
            if (Debug)
            {
                Console.WriteLine("Debug activated");
            }


            Thread thd01 = new Thread(() => Multithreading.playMusic(Activated));
            Thread thd02 = new Thread(() => Multithreading.playSound(Activated));
            Thread thd03 = new Thread(() => Multithreading.playEnvironnement(Activated));

            thd01.Start();
            thd02.Start();
            thd03.Start();

            while(Activated)
            {
                if (!(Process.GetProcessesByName("Cyberpunk2077").Length > 0 || Debug))
                {
                    new FileStream(@"..\music.json", FileMode.Truncate).Close();
                    new FileStream(@"..\env.json", FileMode.Truncate).Close();
                    new FileStream(@"..\sound.json", FileMode.Truncate).Close();
                    System.Environment.Exit(1);
                }

                Thread.Sleep(1000);
            }
        }
    }

      

    public static class Multithreading
    {
        public static void playSound(bool Activate)
        {
            WaveOutEvent outputsound = new WaveOutEvent();

            while(Activate)
            {
                if (outputsound.PlaybackState != PlaybackState.Playing)
                {
                    string sound = "";
                   
                    try
                    {
                        using (StreamReader r = new StreamReader(@"..\sound.json"))
                        {
                            sound = r.ReadToEnd();
                            r.Close();
                        }
                        if (sound.Length != 0)
                        {
                            var file = JsonConvert.DeserializeObject<SoundFile>(sound);
                            outputsound = new WaveOutEvent();
                            //outputsound.Volume = (float)1;
                            using (var audioFile = new AudioFileReader(@"..\..\" + file.path))
                            using (var outputDevice = outputsound)
                            {
                                Console.WriteLine("Playing sounds: " + file.path);

                                audioFile.Volume = Convert.ToSingle(file.volume / 100);

                                outputDevice.Init(audioFile);
                                outputDevice.Play();


                                bool isPlaying = true;
                                string stopfile = @"..\stopsound.txt";
                                string pausefile = @"..\pausesound.txt";
                                while (isPlaying)
                                {
                                    while (outputDevice.PlaybackState == PlaybackState.Playing)
                                    {
                                        if (File.Exists(stopfile) == true)
                                        {
                                            outputDevice.Stop();
                                            File.Delete(stopfile);
                                        }
                                        else if (File.Exists(pausefile) == true)
                                        {
                                            outputDevice.Pause();
                                            Thread.Sleep(1000);
                                        }

                                        else
                                        {

                                            Thread.Sleep(1000);
                                        }
                                    }

                                    while (outputDevice.PlaybackState == PlaybackState.Paused)
                                    {
                                        if (File.Exists(stopfile) == true)
                                        {
                                            outputDevice.Stop();
                                            File.Delete(stopfile);
                                        }
                                        else if (File.Exists(pausefile) == true)
                                        {

                                            Thread.Sleep(1000);
                                        }
                                        else
                                        {
                                            outputDevice.Play();
                                            Thread.Sleep(1000);
                                        }
                                    }

                                    if (outputDevice.PlaybackState == PlaybackState.Stopped)
                                    {
                                        isPlaying = false;
                                    }

                                }
                                Console.WriteLine("sounds played, waiting for another sound");
                                new FileStream(@"..\sound.json", FileMode.Truncate).Close();
                            }
                        }
                    }
                    catch
                    {
                        //Console.WriteLine("waiting for a file");
                    }
                }
            }
        }

        public static void playEnvironnement(bool Activate)
        {

            WaveOutEvent outputenv = new WaveOutEvent();
            while (Activate)
            {
                if (outputenv.PlaybackState != PlaybackState.Playing)
                {
                    string sound = "";
                    try
                    {
                        sound = File.ReadAllText(@"..\env.json");

                        if (sound.Length != 0)
                        {
                            outputenv = new WaveOutEvent();
                            var file = JsonConvert.DeserializeObject<SoundFile>(sound);
                            //outputenv.Volume = (float)0.1;
                            using (var audioFile = new AudioFileReader(@"..\..\" + file.path))
                            using (var outputDevice = outputenv)
                            {
                                Console.WriteLine("Playing sounds: " + file.path);

                                audioFile.Volume = Convert.ToSingle(file.volume / 100);

                                outputDevice.Init(audioFile);
                                outputDevice.Play();

                                bool isPlaying = true;
                                string stopfile = @"..\stopenv.txt";
                                string pausefile = @"..\pauseenv.txt";
                                while (isPlaying)
                                {
                                    while (outputDevice.PlaybackState == PlaybackState.Playing)
                                    {
                                        if (File.Exists(stopfile) == true)
                                        {
                                            outputDevice.Stop();
                                            File.Delete(stopfile);
                                        }
                                        else if (File.Exists(pausefile) == true)
                                        {
                                            outputDevice.Pause();
                                            Thread.Sleep(1000);
                                        }

                                        else
                                        {
                                            Thread.Sleep(1000);
                                        }
                                    }

                                    while (outputDevice.PlaybackState == PlaybackState.Paused)
                                    {
                                        if (File.Exists(stopfile) == true)
                                        {
                                            outputDevice.Stop();
                                            File.Delete(stopfile);
                                        }
                                        else if (File.Exists(pausefile) == true)
                                        {

                                            Thread.Sleep(1000);
                                        }
                                        else
                                        {
                                            outputDevice.Play();
                                            Thread.Sleep(1000);
                                        }
                                    }

                                    if (outputDevice.PlaybackState == PlaybackState.Stopped)
                                    {
                                        isPlaying = false;
                                    }

                                }

                                Console.WriteLine("env played, waiting for another env");
                                new FileStream(@"..\env.json", FileMode.Truncate).Close();
                            }
                        }
                    }
                    catch
                    {
                        // Console.WriteLine("waiting for a file");
                    }
                }
            }
        }


        public static void playMusic(bool Activate)
        {
            WaveOutEvent outputmusic = new WaveOutEvent();

            while (Activate)
            {
                if (outputmusic.PlaybackState != PlaybackState.Playing)
                {
                    string music = "";
                    try
                    {
                        music = File.ReadAllText(@"..\music.json");
                         
                        if (music.Length != 0)
                        {
                            outputmusic = new WaveOutEvent();

                            var file = JsonConvert.DeserializeObject<SoundFile>(music);

                            using (var audioFile = new AudioFileReader(@"..\..\" + file.path))
                            using (var outputDevice = outputmusic)
                            {
                                Console.WriteLine("Playing sounds: " + file.path);

                                audioFile.Volume = Convert.ToSingle(file.volume / 100);

                                outputDevice.Init(audioFile);
                                outputDevice.Play();
                                string stopfile = @"..\stopmusic.txt";
                                string pausefile = @"..\pausemusic.txt";

                                bool isPlaying = true;
                                while (isPlaying)
                                {
                                    while (outputDevice.PlaybackState == PlaybackState.Playing)
                                    {
                                        if (File.Exists(stopfile) == true)
                                        {
                                            outputDevice.Stop();
                                            File.Delete(stopfile);
                                        }
                                        else if (File.Exists(pausefile) == true)
                                        {
                                            outputDevice.Pause();
                                            Thread.Sleep(1000);
                                        }

                                        else
                                        {

                                            Thread.Sleep(1000);
                                        }
                                    }

                                    while (outputDevice.PlaybackState == PlaybackState.Paused)
                                    {
                                        if (File.Exists(stopfile) == true)
                                        {
                                            outputDevice.Stop();
                                            File.Delete(stopfile);
                                        }
                                        else if (File.Exists(pausefile) == true)
                                        {

                                            Thread.Sleep(1000);
                                        }
                                        else
                                        {
                                            outputDevice.Play();
                                            Thread.Sleep(1000);
                                        }
                                    }

                                    if (outputDevice.PlaybackState == PlaybackState.Stopped)
                                    {
                                        isPlaying = false;
                                    }
                                }

                                Console.WriteLine("sounds music, waiting for another music");
                                new FileStream(@"..\music.json", FileMode.Truncate).Close();
                            }
                        }
                    }
                    catch
                    {
                        // Console.WriteLine("waiting for a file");
                    }
                }
            }
        }
    }
    public static class ProcessMonitor
    {
        public static event EventHandler ProcessClosed;

        public static void MonitorForExit(Process process)
        {
            Thread thread = new Thread(() =>
            {
                process.WaitForExit();
                OnProcessClosed(EventArgs.Empty);
            });
            thread.Start();
        }

        private static void OnProcessClosed(EventArgs e)
        {
            if (ProcessClosed != null)
            {
                ProcessClosed(null, e);
            }
        }
    }


}

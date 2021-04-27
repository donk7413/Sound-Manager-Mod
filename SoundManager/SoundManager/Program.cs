﻿using Microsoft.VisualStudio.Threading;
using NAudio.Wave;
using System;
using System.Collections.Generic;
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
            bool test = true;

            string music = "";
            Multithreading multi = new Multithreading();
            Thread thd01 = new Thread(() => multi.playMusic());
            Thread thd02 = new Thread(() => multi.playSound());
            Thread thd03 = new Thread(() => multi.playEnvironnement());
            while (test)
            {
                //await multi.playMusic();
                //     await multi.playSound();
                // Task task1 = Task.Factory.StartNew(() => multi.playMusic());
                // //Task task2 = Task.Factory.StartNew(() => multi.playSound());



                if (!thd02.IsAlive)
                {
                    thd02 = new Thread(() => multi.playSound());
                    thd02.Start();
                }



                // Activer l'exécution newThread.
                if (!thd01.IsAlive)
                {
                    thd01 = new Thread(() => multi.playMusic());
                    thd01.Start();
                }

                if (!thd03.IsAlive)
                {
                    thd03 = new Thread(() => multi.playEnvironnement());
                    thd03.Start();
                }


                //Console.WriteLine("Call Write('-') in main Thread...\n");

                //ExecuteParallel(() => multi.playSound(), () => multi.playMusic());



                // //SomeMethod(multi);



                // //Task.WaitAll(task1, task2);
                // //Console.WriteLine("All threads complete");

            }



        }


        static void NormalAction()
        {
            Console.WriteLine($"Method 1, Thread={Thread.CurrentThread.ManagedThreadId}");
        }
    }

    public class Multithreading
    {
        public WaveOutEvent outputmusic { get; set; }

        public WaveOutEvent outputsound { get; set; }

        public WaveOutEvent outputenv { get; set; }

        public Multithreading()
        {
            this.outputmusic = new WaveOutEvent();

            this.outputsound = new WaveOutEvent();

            this.outputenv = new WaveOutEvent();

        }

        public string playSound()
        {
            if (outputsound.PlaybackState != PlaybackState.Playing)
            {
                string sound = "";
                bool result = false;
                try
                {
                    using (StreamReader r = new StreamReader(@"..\sound.txt"))
                    {
                        sound = r.ReadToEnd();
                        r.Close();
                    }
                    if (sound.Length != 0)
                    {
                        outputsound = new WaveOutEvent();
                        //outputsound.Volume = (float)1;
                        using (var audioFile = new AudioFileReader(@"..\..\"+sound))
                        using (var outputDevice = outputsound)
                        {
                            Console.WriteLine("Playing sounds: " + sound);
                            outputDevice.Init(audioFile);

                            outputDevice.Play();

                            while (outputDevice.PlaybackState == PlaybackState.Playing)
                            {
                                Thread.Sleep(1000);
                            }
                            Console.WriteLine("sounds played, waiting for another sound");
                            new FileStream(@"..\sound.txt", FileMode.Truncate).Close();

                        }

                    }
                    //else
                    //{
                    //    Console.WriteLine("waiting for a sound");
                    //}


                }
                catch
                {
                    Console.WriteLine("waiting for a file");
                }
            }
            return "";

        }

        public string playEnvironnement()
        {
            if (outputenv.PlaybackState != PlaybackState.Playing)
            {
                string sound = "";
                bool result = false;
                try
                {
                    using (StreamReader r = new StreamReader(@"..\env.txt"))
                    {
                        sound = r.ReadToEnd();
                        r.Close();
                    }
                    if (sound.Length != 0)
                    {
                        outputenv = new WaveOutEvent();
                        //outputenv.Volume = (float)0.1;
                        using (var audioFile = new AudioFileReader(@"..\..\"+sound))
                        using (var outputDevice = outputenv)
                        {
                            Console.WriteLine("Playing sounds: " + sound);


                            outputDevice.Init(audioFile);
                            outputDevice.Play();

                            while (outputDevice.PlaybackState == PlaybackState.Playing)
                            {
                                Thread.Sleep(1000);
                            }
                            Console.WriteLine("env played, waiting for another env");
                            new FileStream(@"..\env.txt", FileMode.Truncate).Close();

                        }

                    }
                    //else
                    //{
                    //    Console.WriteLine("waiting for a sound");
                    //}


                }
                catch
                {
                    Console.WriteLine("waiting for a file");
                }
            }
            return "";

        }


        public string playMusic()
        {
            if (outputmusic.PlaybackState != PlaybackState.Playing)
            {
                string music = "";
                try
                {
                    using (StreamReader r = new StreamReader(@"..\music.txt"))
                    {
                        music = r.ReadToEnd();
                        r.Close();
                    }
                    if (music.Length != 0)
                    {
                        outputmusic = new WaveOutEvent();
                        //outputmusic.Volume = (float)0.5;
                        using (var audioFile = new AudioFileReader(@"..\..\" + music))
                        using (var outputDevice = outputmusic)
                        {
                            Console.WriteLine("Playing music: " + music);
                            outputDevice.Init(audioFile);
                            //outputDevice.Volume = (float)1;
                            outputDevice.Play();
                            while (outputDevice.PlaybackState == PlaybackState.Playing)
                            {
                                Thread.Sleep(1000);
                            }
                            Console.WriteLine("sounds music, waiting for another music");
                            new FileStream(@"..\music.txt", FileMode.Truncate).Close();
                        }

                    }
                    //else
                    //{
                    //    Console.WriteLine("waiting for a sound");
                    //}


                }
                catch
                {
                    Console.WriteLine("waiting for a file");
                }

            }
            return "";
        }
    }



}
